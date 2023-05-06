import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/MiniGames/MiniGameMainScreen.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/MiniGames/Quizz/quizzGame.dart';

class Quizz extends MiniGame {
  BuildContext buildContext;
  Function(bool unlocked, Zones zone, int order) restartQuizz;

  Quizz({required super.hud, super.zone, super.level, super.challenge , required this.buildContext, required this.restartQuizz});

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();

  }

  @override
  void onPointsModified(int newPoints, int addedPoints) {
    // TODO: implement onPointsModified
    super.onPointsModified(newPoints, addedPoints);
    if (newPoints == hud.maxPoints) {
      setStars(stars: 3);
    } else if (newPoints >= hud.maxPoints! * 0.6) {
      setStars(stars: 2);
    } else if (newPoints >= hud.maxPoints! * 0.3) {
      setStars(stars: 1);
    }
  }

  @override
  void onRestart() {
    // TODO: implement onRestart
    super.onRestart();
    Navigator.pop(buildContext, true);
    restartQuizz(true, zone, level);
  }


}