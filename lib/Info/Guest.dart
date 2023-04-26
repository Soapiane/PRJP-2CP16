import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:projet2cp/Info/Avatar.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guest extends Info {
  static final Guest _instance = Guest._internal();




  factory Guest() {
    return _instance;
  }

  Guest._internal();

  void setDifficulty(Difficulty value) {
    super.setDifficulty(value);
    GuestRepository().saveUserInfo();
  }



  @override
  void setAvatar(Avatar value) {
    super.setAvatar(value);
    GuestRepository().saveUserInfo();
  }

  @override
  void setSound(bool value) {
    super.setSound(value);
    GuestRepository().saveUserInfo();
  }






}

