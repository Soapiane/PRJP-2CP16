import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

    uploadChallenges();

    print("it's uploading 5");
  }

  void uploadChallenges() async {

    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      List<Map> _challenges = await database!.query('challenge');
      for (int i = 0; i < _challenges.length; i++) {
        print(_challenges[i].toString());
        await uploadChallenge(_challenges[i]);
      }
    }
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
        .update({
      "id": zone['id'],
      "name": zone['name'],
      "stars": zone['stars'],
      "levelsNb": zone['levelsNb'],
      "levelReached": zone['levelReached'],
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
        .child("level${level["level"] as int}")
        .update({
      "id": level['id'],
      "isLocked": level['isLocked'],
      "level": level['level'],
      "stars": level['stars'],
      "isQuiz": level['isQuiz'],
      "zone_id": level['zone_id'],
    });
  }

  Future<void> fetchAndUploadTrophy(Trophy trophy) async {
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

  Future<void> uploadChallenge(Map challenge) async {
    await FirebaseDatabase(databaseURL: databaseLink).reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("challenges")
        .child("challenge${challenge["id"].toString()}").update({
      "id": challenge['id'],
      "state": challenge['state'],
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

    await FirebaseDatabase(databaseURL: databaseLink).reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("challenges")
        .get().then((snapshot) {
      (snapshot.value as Map).forEach((key, value) {
        updateChallenge(value);
      });
    });

    print("it's downloading 4");
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


    Future<void> fetchAndDownloadTrophy(Trophy trophy) async {
      await FirebaseDatabase(databaseURL: databaseLink).reference().child(
          "users").child(FirebaseAuth.instance.currentUser!.uid).child(
          "trophies").child(trophy.id.toString()).once().then((
          DataSnapshot snapshot) {
        updateTrophy(snapshot.value);
      });
    }


    Map compareLevels(Map lvl1, Map lvl2) {
      if (lvl1["isLocked"] == 1 && lvl2["isLocked"] == 0) {
        return lvl2 as Map<String, dynamic>;
      } else if (lvl1["isLocked"] == 0 && lvl2["isLocked"] == 1) {
        return lvl1 as Map<String, dynamic>;
      } else if (lvl1["isLocked"] == 1 && lvl2["isLocked"] == 1) {
        return lvl2 as Map<String, dynamic>;
      } else {
        return ((lvl1["stars"] as int)> lvl2["stars"] ? lvl1 : lvl2);
      }
    }


    Future<void> syncZone(Zones zone) async {

      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
      ///syncing the levels
      List<Map> _levels = (await DatabaseRepository().database!.rawQuery(
              "SELECT * FROM level WHERE zone_id = ? ORDER BY level ASC",
              [zone.id]))
          .toList();
      late Map<dynamic, dynamic> level;

      DatabaseReference ref = FirebaseDatabase(databaseURL: databaseLink)
          .reference()
          .child("users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("zones")
          .child(zone.toString().split(".")[1])
          .child("levels");

      for (int i = 0; i < _levels.length; i++) {
        Map map = {};

        await ref
            .child("level${_levels[i]["level"] as int}")
            .get()
            .then((DataSnapshot snapshot) {
          map = Map<String, dynamic>.from(snapshot.value);
        });

        level = compareLevels(map, _levels[map["level"]]);
        updateLevel(level);
        uploadLevel(level);
        _levels[map["level"]] = level;
      }

      ///syncing the zone

      int allStars = (await DatabaseRepository().database!.rawQuery(
              "SELECT SUM(stars) as Total FROM level GROUP BY zone_id"))
          .toList()[zone.index]["Total"] as int;

      await database!.update(
        "zone",
        {
          "stars": allStars,
        },
        where: "id = ?",
        whereArgs: [zone.id],
      );

      await fetchAndUploadZone(zone);

      ///syncing the trophies

      SharedPreferences prefs = await SharedPreferences.getInstance();

      Map zoneInfo = (await DatabaseRepository().database!.query(
        "zone",
        where: "id = ?",
        whereArgs: [zone.id],
      ))[0];

      int trophyAcquired = (await DatabaseRepository().database!.query(
        "trophy",
        where: "id = ?",
        whereArgs: [Zones.ville.id],
      ))
          .toList()[0]["isCollected"] as int;

      if (allStars == zoneInfo["levelsNb"] * 3 && trophyAcquired == 0) {
        DatabaseRepository().database!.update(
              "trophy",
              {
                "isCollected": 1,
              },
              where: "id = ?",
              whereArgs: [Zones.ville.id],
            );
        prefs.setInt("newTrophy", Zones.ville.index);
      }

      trophyAcquired = (await DatabaseRepository().database!.query(
        "trophy",
        where: "id = ?",
        whereArgs: [Zones.ville.id],
      ))
          .toList()[0]["isCollected"] as int;

      FirebaseDatabase(databaseURL: databaseLink)
          .reference()
          .child("users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("trophies")
          .child("trophy${Zones.ville.id.toString()}")
          .update({
        "isCollected": trophyAcquired,
      });
    }
  }


    Future<void> syncChallenges(Function onDone) async {

      bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      print("SYNCING CHALLENGES ");

      DatabaseReference ref;

        List<Map> challenges =  await DatabaseRepository().database!.query("challenge");


        ref = FirebaseDatabase(databaseURL: databaseLink)
            .reference()
            .child("users")
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child("challenges");

        for (Map localChallenge in challenges) {
          Map remoteChallenge = {};

          await ref.child("challenge${localChallenge["id"] as int}").get().then((DataSnapshot snapshot) {
            remoteChallenge = Map<String, dynamic>.from(snapshot.value);
          });

          if (localChallenge["state"] == 0 ) {
            await DatabaseRepository().database!.update(
              "challenge",
              {
                "state": remoteChallenge["state"],
              },
              where: "id = ?",
              whereArgs: [localChallenge["id"]],
            );
          } else if (remoteChallenge["state"] == 0) {
            await ref.child("challenge${localChallenge["id"] as int}")
                .update({
              "state" : localChallenge["state"],
            });
          }


        }


      //here we're downloading the challenges
      print("DOWNLAODING CHALLENGES");
      await ref.get().then((snapshot) {
        (snapshot.value as Map).forEach((key, value) {
          print(value.toString());
          updateChallenge(value);
        });
      }).then((value) => onDone.call());
    } else {
      onDone.call();
    }

    }

    Future<void> sync() async {
      if (FirebaseAuth.instance.currentUser != null) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        await updateUserInfo();

        for (Zones zone in Zones.values) {
          await syncZone(zone);
        }


        ///challenges syncing
        await syncChallenges((){});
      }
    }
  }


}