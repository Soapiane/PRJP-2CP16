import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Info/Avatar.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Info {

  late bool _sound = true;
  late Difficulty _difficulty = Difficulty.EASY;
  late Avatar _avatar = Avatar.avatar0;


  Difficulty get difficulty => _difficulty;


  void setDifficulty(Difficulty value) {
    _difficulty = value;
  }



  Avatar get avatar => _avatar;

  void setAvatar(Avatar value) {
    _avatar = value;
  }

  bool get sound => _sound;

  void setSound(bool value) {
    _sound = value;
  }
}

