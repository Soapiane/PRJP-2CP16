import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Info/Avatar.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Language.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Sound.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info {


  /**
   *
   * this class contains all the info that both guest and user players have
   *
   */

  static bool sound = false;
  static Difficulty difficulty = Difficulty.EASY;
  static Language language = Language.french;
  late Avatar _avatar = Avatar.avatar0;
  static late SharedPreferences _prefs;


  static FutureOr<void> iniState() async {

    //get the info from local storage
    _prefs = await SharedPreferences.getInstance();
    sound = _prefs.getBool("sound") ?? true;
    difficulty = Difficulty.values[_prefs.getInt("difficulty") ?? 0];
    language = Language.values[_prefs.getInt("language") ?? 0];
  }



  //setters and getters


  static void setDifficulty(Difficulty value) {
    difficulty = value;
    _prefs.setInt("difficulty", Difficulty.values.indexOf(value));
  }


  Avatar get avatar => _avatar;

  void setAvatar(Avatar value) {
    _avatar = value;
  }


  static void setSound(bool value) {
    sound = value;
    _prefs.setBool("sound", value);
    Sound().changeSoundState(value);
  }

  static void setLanguage(Language value) {
    language = value;
    _prefs.setInt("language", Language.values.indexOf(value));
  }

}

