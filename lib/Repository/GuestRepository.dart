import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet2cp/Info/Avatar.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Guest.dart';
import 'package:projet2cp/Repository/Repository.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projet2cp/Collectables/Trophy.dart';
import 'package:uuid/uuid.dart';

class GuestRepository extends Repository {

  static final GuestRepository _instance = GuestRepository._internal();

  factory GuestRepository() {
    return _instance;
  }

  GuestRepository._internal();


  @override
  Future<String> getDBPath() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'guest.db');
    return path;
  }


  @override
  Future<void> openDB() async {
    if (database == null) {
        database = await initDB();
        getUserInfo();
    }
  }



  @override
  Future<void> getUserInfo() async {
    //gets guest info from the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Guest().setAvatar(Avatar.values[prefs.getInt("avatarGuest") ?? 0]);
    Guest().setDifficulty(Difficulty.values[prefs.getInt("difficultyGuest") ?? 0]);
  }

  @override
  Future<void> saveUserInfo() async {
    //saves guest info to the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("avatarGuest", Guest().avatar.index);
    prefs.setInt("difficultyGuest", Guest().difficulty.index);
  }












}