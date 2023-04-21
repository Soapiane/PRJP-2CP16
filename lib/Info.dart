import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Avatar.dart';
import 'package:projet2cp/Difficulty.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Info {

  late Difficulty _difficulty = Difficulty.EASY;
  late Avatar _avatar = Avatar.avatar0;


  Difficulty get difficulty => _difficulty;

  set difficulty(Difficulty value) {
    _difficulty = value;
  }



  Avatar get avatar => _avatar;

  set avatar(Avatar value) {
    _avatar = value;
  }




}

