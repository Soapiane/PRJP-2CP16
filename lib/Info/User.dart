import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Info/Avatar.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends Info {
  static final User _instance = User._internal();

  late String _name = "";



  factory User() {
    return _instance;
  }

  User._internal();



  @override
  void setDifficulty(Difficulty value) {
    super.setDifficulty(value);
    DatabaseRepository().saveUserInfo();
  }


  String get name => _name;


  void setName(String value) {
    _name = value;
    DatabaseRepository().saveUserInfo();
  }

  @override
  void setAvatar(Avatar value) {
    super.setAvatar(value);
    DatabaseRepository().saveUserInfo();
  }

  @override
  void setSound(bool value) {
    super.setSound(value);
    DatabaseRepository().saveUserInfo();
  }





}

