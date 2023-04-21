import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projet2cp/Avatar.dart';
import 'package:projet2cp/Difficulty.dart';
import 'package:projet2cp/Zones.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projet2cp/User.dart' as user;
import 'package:projet2cp/Collectables/Trophy.dart';
import 'package:uuid/uuid.dart';

class DatabaseRepository {

  static final DatabaseRepository _instance = DatabaseRepository._internal();

  factory DatabaseRepository() {
    return _instance;
  }

  DatabaseRepository._internal();

  Database? _database;
  static const String _databaseLink = "https://projet2cp-1c628-default-rtdb.europe-west1.firebasedatabase.app/";

  Future _createDB(Database db, int version) async {
    //zones table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS zone (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        stars INTEGER,
        levels INTEGER,
        levelReached INTEGER,
        isFinished INTEGER
      )
    ''');
    //levels table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS level (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        level INTEGER,
        stars INTEGER,
        isQuiz INTEGER,
        zone_id INTEGER,
        FOREIGN KEY (zone_id) REFERENCES zone(id)
      )
    ''');
    //trophies table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS trophy (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isCollected INTEGER
      )
    ''');

    //challenges table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS challenge (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        challengeIndex INTEGER,
        state INTEGER
      )
    ''');

    //information table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS information (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        infoIndex INTEGER,
        state INTEGER
      )
    ''');

    for (int i = 0; i < 4; i++) {
      int zone_id = await db.insert('zone', {
        'name': Zones.values[i].toString().split('.')[1],
        'stars': 0,
        'levels': 8,
        'levelReached': 0,
        'isFinished': 0
      });

      for (int j = 0; j < 8; j++) {
        await db.insert('level', {
          'level': j,
          'stars': 0,
          'zone_id': zone_id,
          'isQuiz': 0
        });
      }
    }

    for (var e in Trophies.values) {
      await db.insert('trophy', {
        'isCollected': 0
      });
    }

    //TODO: add challenges and information to the database





    print("it's creating");


  }

  Future<String> getDBPath() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '${FirebaseAuth.instance.currentUser!.uid}.db');
    return path;
  }

  Future<Database> _initDB() async {
    final path = await getDBPath();

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> openDB() async {
    if (_database == null) {
      if (FirebaseAuth.instance.currentUser != null) {
        _database = await _initDB();
        getUserInfo();
      }
    }
  }

  Future<void> closeDB() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }


  }

  Future<void> deleteDB() async {
    if (_database != null) {
      final path = await getDBPath();
      databaseFactory.deleteDatabase(path).then((value) => print("it's deleting the db"));
      _database = null;
    }
  }


  Future<void> signOut() async {
    await DatabaseRepository().deleteDB();

    user.User().name = "";
    user.User().avatar = Avatar.values[0];
    user.User().difficulty = Difficulty.values[0];

    await FirebaseAuth.instance.signOut();
  }

  Future<void> getUserInfo() async {
    //gets user info from the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.User().name = prefs.getString("name") ?? "Player";
    user.User().avatar = Avatar.values[prefs.getInt("avatar") ?? 0];
    user.User().difficulty = Difficulty.values[prefs.getInt("difficulty") ?? 0];
  }

  Future<void> synchronizeDB() async {

  }


  Future<void> upload() async {
    await uploadUserInfo();

    print("it's uploading 1");

    List<Map> _zones = await _database!.query('zone');
    for (int i = 0; i < _zones.length; i++) {
      await uploadZone(_zones[i]);
    }

    print("it's uploading 2");
    List<Map> _levels = await _database!.query('level');
    for (int i = 0; i < _levels.length; i++) {
      await uploadLevel(_levels[i]);
    }
    print("it's uploading 3");

    List<Map> _trophies = await _database!.query('trophy');
    for (int i = 0; i < _trophies.length; i++) {
      await uploadTrophy(_trophies[i]);
    }

    print("it's uploading 4");
  }

  Future<void> uploadUserInfo() async {
    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).update({
      "id" : FirebaseAuth.instance.currentUser!.uid,
      "name": user.User().name,
      "avatar": user.User().avatar.index,
      "difficulty": user.User().difficulty.index,
    });
  }

  Future<void> fetchAndUploadZone(Zones zone) async {

    List<Map> _zone = await _database!.query('zone',
      where: 'id = ?',
      whereArgs: [zone.id],
    );
    
    await uploadZone(_zone[0]);
  }
  
  Future<void> uploadZone(Map zone) async {
    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("zones").child(zone["name"]).set({
      "id" : zone['id'],
      "name": zone['name'],
      "stars": zone['stars'],
      "levels": zone['levels'],
      "levelReached": zone['levelReached'],
      "isFinished": zone['isFinished'],
    });

  }

  Future<void> fetchAndUploadLevel(Zones zone, int level) async {
    List<Map> _level = await _database!.query('level',
      where: 'zone_id = ? AND level = ?',
      whereArgs: [zone.id, level],
    );
    await uploadLevel(_level[0]);
  }
  
  Future<void> uploadLevel(Map level) async {
    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("levels").child(level["id"].toString()).update({
      "id" : level['id'],
      "level": level['level'],
      "stars": level['stars'],
      "isQuiz": level['isQuiz'],
      "zone_id": level['zone_id'],
    });
  }

  Future<void> fetchAndUploadTrophy(Trophies trophy) async {
    List<Map> _trophy = await _database!.query('trophy',
      where: 'id = ?',
      whereArgs: [trophy.index],
    );
    await uploadTrophy(_trophy[0]);
  }

  Future<void> uploadTrophy(Map trophy) async {
    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("trophies").child(trophy["id"].toString()).update({
      "id" : trophy['id'],
      "isCollected": trophy['isCollected'],
    });
  }


  Future<void> saveUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', user.User().name);
    await prefs.setInt('avatar', user.User().avatar.index);
    await prefs.setInt('difficulty', user.User().difficulty.index);
  }
  
  
  Future<void> download() async {

    await updateUserInfo();


    print("it's downloading 1");



    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("zones").get().then((snapshot) {
      (snapshot.value as Map).forEach((key, value) {
        updateZone(value);
      });
    });


    print("it's downloading 2");



    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("levels").onValue.listen((event) async {

      for (var level in event.snapshot.value ) {
          updateLevel(level);

      }

    });


    print("it's downloading 3");




    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("trophies").onValue.listen((event) {
      for (Map trophy in event.snapshot.value ) {
        updateTrophy(trophy);
      }
    });


    print("it's downloading 4");
    
  }
  
  Future<void> updateUserInfo() async {
    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).once().then((DataSnapshot snapshot) {
      user.User().name = snapshot.value["name"];
      user.User().avatar = Avatar.values[snapshot.value["avatar"]];
      user.User().difficulty = Difficulty.values[snapshot.value["difficulty"]];
    });
  }
  
  Future<void> downloadAndUpdateZone(Zones zone) async {
    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("zones").child(zone.toString().split(".")[1]).once().then((DataSnapshot snapshot) {
      updateZone(snapshot.value);
    });
  }
  
  Future<void> updateZone(Map zone) async {
    _database!.update('zone', {
      'stars': zone["stars"],
      'levelReached': zone["levelReached"],
      'isFinished': zone["isFinished"],
    },
      where: 'id = ?',
      whereArgs: [zone["id"]],
    );
  }
  

  Future<void> downloadAndUpdateLevel(Zones zone, int level) async {
    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("levels").onValue.listen((event) async {

      for (var level in event.snapshot.value ) {
        if (level["zone_id"] == zone.id && level["level"] == level) {
          updateLevel(level);
        }
      }

    });
  }

  Future<void> updateLevel(Map level) async {
    _database!.update('level', {
      'stars': level["stars"],
      'isQuiz': level["isQuiz"],
    },
      where: 'id = ?',
      whereArgs: [level["id"]],
    );
  }

  Future<void> fetchAndDownloadTrophy(Trophies trophy) async {
    await FirebaseDatabase(databaseURL: _databaseLink).reference().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("trophies").child(trophy.id.toString()).once().then((DataSnapshot snapshot) {
      updateTrophy(snapshot.value);
    });
  }

  Future<void> updateTrophy(Map trophy) async {
    _database!.update('trophy', {
      'isCollected': trophy["isCollected"],
    },
      where: 'id = ?',
      whereArgs: [trophy["id"]],
    );
  }

  








}