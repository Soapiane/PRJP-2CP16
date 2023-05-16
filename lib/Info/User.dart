import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Info/Avatar.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends Info {


  /**
   * extends [Info] super class and adds the syncing feature to avatar
   * along with the name attribute and it's saving + syncing features
   */
  static final User _instance = User._internal();

  late String _name = "";



  factory User() {
    return _instance;
  }

  User._internal();





  String get name => _name;


  Future<void> setName(String value) async {
    _name = value;
    await DatabaseRepository().saveUserInfo();
  }

  @override
  void setAvatar(Avatar value) {
    super.setAvatar(value);
    DatabaseRepository().saveUserInfo();
  }





}

