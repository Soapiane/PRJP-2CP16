import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Avatar.dart';
import 'package:projet2cp/Difficulty.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static final User _instance = User._internal();

  late Difficulty _difficulty = Difficulty.EASY;
  late String _name = "";
  late Avatar _avatar = Avatar.avatar0;



  factory User() {
    return _instance;
  }

  User._internal();

  Difficulty get difficulty => _difficulty;

  set difficulty(Difficulty value) {
    _difficulty = value;
    _saveUserInfo();
  }


  String get name => _name;

  set name(String value) {
    _name = value;
    _saveUserInfo();
  }


  Avatar get avatar => _avatar;

  set avatar(Avatar value) {
    _avatar = value;
    _saveUserInfo();
  }


  void signOut(){
    DatabaseRepository().deleteDB();
    FirebaseAuth.instance.signOut();
  }

  Future<void> _saveUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _name);
    await prefs.setInt('avatar', _avatar.index);
    await prefs.setInt('difficulty', _difficulty.index);
  }

}

