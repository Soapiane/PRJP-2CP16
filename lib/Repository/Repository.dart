import 'package:projet2cp/Collectables/Trophy.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository {


  Database? database;

  Future<void> printDB() async {
    if (database != null) {

      List<Map> _zones = await database!.query('zone');
      for (int i = 0; i < _zones.length; i++) {
        print(_zones[i]);
      }

      List<Map> _levels = await database!.query('level');
      for (int i = 0; i < _levels.length; i++) {
        print(_levels[i]);
      }

      List<Map> _trophies = await database!.query('trophy');
      for (int i = 0; i < _trophies.length; i++) {
        print(_trophies[i]);
      }
    }
  }

  Future createDB(Database db, int version) async {
    //zones table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS zone (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        stars INTEGER,
        levelsNb INTEGER,
        levelReached INTEGER
      )
    ''');
    //levels table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS level (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isLocked INTEGER,
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
        isCollected INTEGER,
        title TEXT
      )
    ''');

    //challenges table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS challenge (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        state INTEGER,
        title TEXT
      )
    ''');

    for (int i = 0; i < 4; i++) {
      int zone_id = await db.insert('zone', {
        'name': Zones.values[i].toString().split('.')[1],
        'stars': 0,
        'levelsNb': 8,
        'levelReached': 0,
      });

      for (int j = 0; j < 8; j++) {
        await db.insert('level', {
          'level': j,
          'isLocked': j == 0 ? 0 : 1,
          'stars': 0,
          'zone_id': zone_id,
          'isQuiz': j == 7 ? 1 : 0,
        });
      }
    }

    for (Trophy e in Trophy.values) {
      await db.insert('trophy', {
        'isCollected': 0,
        'title': e.title,
      });
    }


    for (int i = 0 ; i < 4; i++){
      await db.insert('challenge', {
        'state': 0,
        'title': "Challenge ${i+1}",
      });
    }

    //TODO: add challenges to the database





    print("it's creating db");


  }

  Future<String> getDBPath();

  Future<Database> initDB() async {
    final path = await getDBPath();
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future<void> openDB();


  Future<void> closeDB() async {
    if (database != null) {
      await database!.close();
      database = null;
    }
  }

  Future<void> deleteDB() async {
    if (database != null) {
      final path = await getDBPath();
      databaseFactory.deleteDatabase(path).then((value) => print("it's deleting the db"));
      database = null;
    }
  }

  Future<void> getUserInfo();
  Future<void> saveUserInfo();

  Future<void> updateZone(Map zone) async {
    database!.update('zone', {
      'stars': zone["stars"],
      'levelReached': zone["levelReached"],
    },
      where: 'id = ?',
      whereArgs: [zone["id"]],
    );
  }

  Future<void> updateLevel(Map level) async {
    database!.update('level', {
      'isLocked': level["isLocked"],
      'stars': level["stars"],
      'isQuiz': level["isQuiz"],
    },
      where: 'id = ?',
      whereArgs: [level["id"]],
    );
  }

  Future<void> updateTrophy(Map trophy) async {
    await database!.update('trophy', {
      'isCollected': trophy["isCollected"],
    },
      where: 'id = ?',
      whereArgs: [trophy["id"]],
    );
  }

  Future<void> updateChallenge(Map challenge) async {
    await database!.update('challenge', {
      'state': challenge["state"],
    },
      where: 'id = ?',
      whereArgs: [challenge["id"]],
    );
  }




}
