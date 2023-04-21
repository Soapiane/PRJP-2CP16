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

class GuestRepository {

  static final GuestRepository _instance = GuestRepository._internal();

  factory GuestRepository() {
    return _instance;
  }

  GuestRepository._internal();

  Database? _database;

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





    print("it's creating guest db");


  }

  Future<String> getDBPath() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'guest.db');
    return path;
  }

  Future<Database> _initDB() async {
    final path = await getDBPath();

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> openDB() async {
    if (_database == null) {
        _database = await _initDB();
        getUserInfo();
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


  Future<void> getUserInfo() async {
    //gets guest info from the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.User().avatar = Avatar.values[prefs.getInt("avatarGuest") ?? 0];
    user.User().difficulty = Difficulty.values[prefs.getInt("difficultyGuest") ?? 0];
  }

  Future<void> saveUserInfo() async {
    //saves guest info to the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("avatarGuest", user.User().avatar.index);
    prefs.setInt("difficultyGuest", user.User().difficulty.index);
  }












}