import 'package:projet2cp/Collectables/Trophy.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository {

  //core local database management


  static const List<String> _challenges = [
    "Prendre une bouteille réutilisable au lieu des bouteilles en plastique pendant 1 journée",
    "Passer 30 minutes à nettoyer le parc ou la rue",
    "Collecter 20 bouchons de bouteilles en plastique pour les recycler",
    "Utiliser les escaliers au lieu de l’ascenseur, pendant une journée",
    "Planter un arbre",
    "Réparer un objet cassé au lieu de le jeter et en acheter un nouveau",
    "Passer une journée entière sans sacs en plastique",
    "Arroser les plantes de la maison, ou celles à l’extérieur",
    "Ramasser 10 déchets dans le parc ou dans la rue",
    "Fabriquer un objet à partir de matériaux recyclés ou récupérés",
    "Passer une journée entière en n'utilisant que des lumières naturelles ou des bougies",
    "Eteindre les lumières une heure plus tôt",
    "Passer une journée entière sans produire de déchets plastiques",
    "Ramasser 5 bouteilles en plastique",
    "Ne rien jeter par terre pendant une journée",
    "Manger exclusivement des légumes ou des fruits de saison dans le gouté"
  ];


  Database? database;

  //to show database, used for tests
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


    //inserting zones,the last one is the for the random quiz
    for (int i = 0; i < 5; i++) {
      int zone_id = await db.insert('zone', {
        'name': Zones.values[i].toString().split('.')[1],
        'stars': 0,
        'levelsNb': i !=4 ? 4 : 1,
        'levelReached': 0,
      });

      //inserting levels of each zone, the 4th one is the quiz and the first one is unlocked
      //except of the 5th zone, only one level and it's the random quiz

      if (i!=4) {
        for (int j = 0; j < 4; j++) {
          await db.insert('level', {
            'level': j,
            'isLocked': j == 0 ? 0 : 1,
            'stars': 0,
            'zone_id': zone_id,
            'isQuiz': j == 3 ? 1 : 0,
          });
        }
      } else {
        await db.insert('level', {
          'level': 3,
          'isLocked': 0,
          'stars': 0,
          'zone_id': zone_id,
          'isQuiz': 1,
        });
      }
    }


    //inserting trophies
    for (Trophy e in Trophy.values) {
      await db.insert('trophy', {
        'isCollected': 0,
        'title': e.title,
      });
    }


    //inserting challenges
    for (String challenge in _challenges) {
      await db.insert('challenge', {
        'state': 0,
        'title': challenge,
      });

    }








  }

  Future<String> getDBPath();

  Future<Database> initDB() async {
    //this function opens the database, if it doesn't exist, it gets created
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


  //these are the update functions, these update the values of the database
  //you give a HashMap and values in the local DB will be replaced with the map values
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
