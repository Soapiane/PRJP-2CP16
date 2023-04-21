import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Avatar.dart';
import 'package:projet2cp/Difficulty.dart';
import 'package:projet2cp/Info.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends Info {
  static final User _instance = User._internal();

  late String _name = "";



  factory User() {
    return _instance;
  }

  User._internal();


  set difficulty(Difficulty value) {
    difficulty = value;
    DatabaseRepository().saveUserInfo();
  }


  String get name => _name;

  set name(String value) {
    _name = value;
    DatabaseRepository().saveUserInfo();
  }


  set avatar(Avatar value) {
    avatar = value;
    DatabaseRepository().saveUserInfo();
  }




}

