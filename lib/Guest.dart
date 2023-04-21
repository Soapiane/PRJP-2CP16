import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Avatar.dart';
import 'package:projet2cp/Difficulty.dart';
import 'package:projet2cp/Info.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guest extends Info {
  static final Guest _instance = Guest._internal();




  factory Guest() {
    return _instance;
  }

  Guest._internal();

  set difficulty(Difficulty value) {
    difficulty = value;
    GuestRepository().saveUserInfo();
  }



  set avatar(Avatar value) {
    avatar = value;
    GuestRepository().saveUserInfo();
  }




}

