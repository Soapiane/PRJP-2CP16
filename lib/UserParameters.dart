import 'package:projet2cp/Difficulty.dart';

class UserParameters {
  static final UserParameters _instance = UserParameters._internal();
  late Difficulty _difficulty = Difficulty.EASY;


  factory UserParameters() {
    return _instance;
  }

  UserParameters._internal();

  Difficulty get difficulty => _difficulty;

  set difficulty(Difficulty value) {
    _difficulty = value;
  }
}

