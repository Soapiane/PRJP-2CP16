import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/MiniGames/MiniGameMainScreen.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/MiniGames/Quizz/quizzGame.dart';

class Quizz extends MiniGame {
  Function(bool unlocked, Zones zone, int order, {bool? restart}) restartQuizz;

  Quizz( {required super.hud, required super.zone, super.level, super.challenge , required super.context, required this.restartQuizz, required bool restart}){

    if (!restart) showTutorial("assets/tutorials/quiz.png");
  }

  @override
  FutureOr<void> onLoad() {

    // TODO: implement onLoad
    return super.onLoad();
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
  }

  @override
  FutureOr<void> showTutorial(String? path) async {

    await Future.delayed(Duration(milliseconds: 100), () async {
      await super.showTutorial(path);
    },);
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
    Navigator.pop(context!, true);
    restartQuizz(true, zone, level+1, restart: true);
  }






}