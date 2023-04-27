import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projet2cp/Info/Avatar.dart';
import 'package:projet2cp/Repository/Repository.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projet2cp/Info/User.dart' as user;
import 'package:projet2cp/Collectables/Trophy.dart';
import 'package:uuid/uuid.dart';

class DatabaseRepository extends Repository {

  static final DatabaseRepository _instance = DatabaseRepository._internal();

  factory DatabaseRepository() {
    return _instance;
  }

  DatabaseRepository._internal();

  static const String databaseLink = "https://projet2cp-1c628-default-rtdb.europe-west1.firebasedatabase.app/";

  @override
  Future<String> getDBPath() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '${FirebaseAuth.instance.currentUser!.uid}.db');
    return path;
  }

  @override
  Future<void> openDB() async {
    if (database == null) {
      if (FirebaseAuth.instance.currentUser != null) {
        database = await initDB();
        getUserInfo();
      }
    }
  }


  Future<void> signOut() async {
    await deleteDB();

    user.User().setName("");
    user.User().setAvatar(Avatar.values[0]);

    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> getUserInfo() async {
    //gets user info from the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.User().setName(prefs.getString("name") ?? "Player");
    user.User().setAvatar(Avatar.values[prefs.getInt("avatar") ?? 0]);
  }


  @override
  Future<void> saveUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', user
        .User()
        .name);
    await prefs.setInt('avatar', user
        .User()
        .avatar
        .index);

  }

  Future<void> updateUserInfo() async {
    await FirebaseDatabase(databaseURL: databaseLink).reference().child("users")
        .child(FirebaseAuth.instance.currentUser!.uid).once()
        .then((DataSnapshot snapshot) {
      user.User().setName(snapshot.value["name"]);
      user.User().setAvatar(Avatar.values[snapshot.value["avatar"]]);
    });
  }


  Future<void> upload() async {
    await uploadUserInfo();

    print("it's uploading 1");

    List<Map> _zones = await database!.query('zone');
    for (int i = 0; i < _zones.length; i++) {
      await uploadZone(_zones[i]);
    }

    print("it's uploading 2");
    List<Map> _levels = await database!.query('level');
    for (int i = 0; i < _levels.length; i++) {
      await uploadLevel(_levels[i]);
    }
    print("it's uploading 3");

    List<Map> _trophies = await database!.query('trophy');
    for (int i = 0; i < _trophies.length; i++) {
      await uploadTrophy(_trophies[i]);
    }

    print("it's uploading 4");
  }

  Future<void> uploadUserInfo() async {
    await FirebaseDatabase(databaseURL: databaseLink).reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "id": FirebaseAuth.instance.currentUser!.uid,
      "name": user
          .User()
          .name,
      "avatar": user
          .User()
          .avatar
          .index,
    });
  }

  Future<void> fetchAndUploadZone(Zones zone) async {
    List<Map> _zone = await database!.query('zone',
      where: 'id = ?',
      whereArgs: [zone.id],
    );

    await uploadZone(_zone[0]);
  }

  Future<void> uploadZone(Map zone) async {
    await FirebaseDatabase(databaseURL: databaseLink).reference().child("users")
        .child(FirebaseAuth.instance.currentUser!.uid).child("zones").child(
        zone["name"])
        .set({
      "id": zone['id'],
      "name": zone['name'],
      "stars": zone['stars'],
      "levelsNb": zone['levelsNb'],
      "levelReached": zone['levelReached'],
      "isFinished": zone['isFinished'],
    });
  }

  Future<void> fetchAndUploadLevel(Zones zone, int level) async {
    List<Map> _level = await database!.query('level',
      where: 'zone_id = ? AND level = ?',
      whereArgs: [zone.id, level],
    );
    await uploadLevel(_level[0]);
  }

  Future<void> uploadLevel(Map level) async {
    await FirebaseDatabase(databaseURL: databaseLink).reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("zones")
        .child(Zones.values[level["zone_id"] - 1].toString().split(".")[1])
        .child("levels")
        .child("level${level["level"].toString()}")
        .update({
      "id": level['id'],
      "isLocked": level['isLocked'],
      "level": level['level'],
      "stars": level['stars'],
      "isQuiz": level['isQuiz'],
      "zone_id": level['zone_id'],
    });
  }

  Future<void> fetchAndUploadTrophy(Trophies trophy) async {
    List<Map> _trophy = await database!.query('trophy',
      where: 'id = ?',
      whereArgs: [trophy.index],
    );
    await uploadTrophy(_trophy[0]);
  }

  Future<void> uploadTrophy(Map trophy) async {
    await FirebaseDatabase(databaseURL: databaseLink).reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("trophies")
        .child("trophy${trophy["id"].toString()}").update({
      "id": trophy['id'],
      "isCollected": trophy['isCollected'],
    });
  }


  Future<void> download() async {
    await updateUserInfo();


    print("it's downloading 1");


    await FirebaseDatabase(databaseURL: databaseLink).reference().child("users")
        .child(FirebaseAuth.instance.currentUser!.uid).child("zones").get()
        .then((snapshot) {
      (snapshot.value as Map).forEach((key, value) {
        updateZone(value);
        (value["levels"] as Map).forEach((key, value) {
          updateLevel(value);
        });
      });
    });


    print("it's downloading 2");


    await FirebaseDatabase(databaseURL: databaseLink).reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("trophies")
        .get().then((snapshot) {
      (snapshot.value as Map).forEach((key, value) {
        updateTrophy(value);
      });
    });

    print("it's downloading 3");
  }


    Future<void> downloadAndUpdateZone(Zones zone) async {
      await FirebaseDatabase(databaseURL: databaseLink).reference().child(
          "users").child(FirebaseAuth.instance.currentUser!.uid).child("zones")
          .child(zone.toString().split(".")[1]).once()
          .then((DataSnapshot snapshot) {
        updateZone(snapshot.value);
      });
    }


    Future<void> downloadAndUpdateLevel(Zones zone, int level) async {
      await FirebaseDatabase(databaseURL: databaseLink).reference()
          .child("users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("zones")
          .child(zone.toString().split(".")[1])
          .child("levels")
          .child(level.toString()).get().then((snapshot) {
        updateLevel(snapshot.value);
      });
    }


    Future<void> fetchAndDownloadTrophy(Trophies trophy) async {
      await FirebaseDatabase(databaseURL: databaseLink).reference().child(
          "users").child(FirebaseAuth.instance.currentUser!.uid).child(
          "trophies").child(trophy.id.toString()).once().then((
          DataSnapshot snapshot) {
        updateTrophy(snapshot.value);
      });
    }


    Map<String, dynamic> compareLevels(Map<Object?, Object?> lvl1, Map lvl2) {
      if (lvl1["isLocked"] == 1 && lvl2["isLocked"] == 0) {
        return lvl2 as Map<String, dynamic>;
      } else if (lvl1["isLocked"] == 0 && lvl2["isLocked"] == 1) {
        return lvl1 as Map<String, dynamic>;
      } else if (lvl1["isLocked"] == 1 && lvl2["isLocked"] == 1) {
        return lvl1 as Map<String, dynamic>;
      } else {
        return ((lvl1["stars"] as int)> lvl2["stars"] ? lvl1 : lvl2)  as Map<String, dynamic>;
      }
    }


    Future<void> syncZone(Zones zone) async {

      List<Map> _levels = (await DatabaseRepository().database!.rawQuery("SELECT * FROM level WHERE zone_id = ? ORDER BY level ASC", [3])).toList();
      late Map<dynamic, dynamic> level;
      FirebaseDatabase(databaseURL: databaseLink)
          .reference()
          .child("users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("zones")
          .child(zone.toString().split(".")[1])
          .child("levels").get().then((snapshot) {
            (snapshot.value as Map).forEach((key, value) {

              Map map = Map<String, dynamic>.from(value) as Map<String, dynamic>;

              level = compareLevels(map , _levels[map["level"]]);
              updateLevel(level);
              uploadLevel(level);
              _levels[map["level"]] = level;
            });
          });



      int allStars = (await DatabaseRepository().database!.rawQuery("SELECT SUM(stars) as Total FROM level GROUP BY zone_id")).toList()[zone.index]["Total"] as int;
      int isFinished = 0;
      if (allStars > 0 && _levels.last["stars"] > 0) {
        isFinished = 1;
        if (allStars == 3 * _levels.length) {

        }
      }
      await database!.update(
        "zone",
        {
          "stars": allStars,
        },
        where: "id = ?",
        whereArgs: [zone.id],
      );
    }


}