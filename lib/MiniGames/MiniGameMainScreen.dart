

import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/MainScreen.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/MiniGames/Hud/MiniGameHUD.dart';
import 'package:projet2cp/MiniGames/Quizz/Quizz.dart';
import 'package:projet2cp/MiniGames/Quizz/quizzGame.dart';
import 'package:projet2cp/MiniGames/TurningPipes/TurningPipes.dart';
import 'package:projet2cp/Navigation/Zones.dart';

class MiniGameMainScreen extends StatelessWidget {

  final int miniGameOrder;
  late MiniGameHUD hud;
  final Zones zone;
  late String backgroundImageUrl;
  late Widget mainScreen;
  bool blur = false;
  MainState mainScreenRef;


  MiniGameMainScreen({super.key,required this.miniGameOrder,  required this.zone, required this.mainScreenRef}){
    backgroundImageUrl = zone.backgroundImagePath;
    getHUD();
  }

  void getHUD(){
    hud = MiniGameHUD(
      zone: zone,
    );
  }



  void getMainScreen(BuildContext context){
    //chose the game based on the zone and the order
    /**
    switch (zone) {
      case Zones.ville:
        switch (miniGameOrder) {
          case 1:
            {
              blur = true;
              mainScreen = GameWidget(game: TurningPipes(hud: hud, context: context ));
            }
            break;
          case 4:
            {
              blur = true;
              mainScreen = QuizzGame(
                zone: zone,
                gameRef: Quizz(
                  hud: hud,
                  zone: zone,
                  level: miniGameOrder,
                  buildContext: context,
                  restartQuizz: mainScreenRef.levelTaped,
                ),
              );
            }
            break;
        }
        break;
      case Zones.zoneIndustrielle:
        switch (miniGameOrder) {
          case 4:
            {
              blur = true;
              blur = true;
              mainScreen = QuizzGame(
                zone: zone,
                gameRef: Quizz(
                  hud: hud,
                  zone: zone,
                  level: miniGameOrder,
                  buildContext: context,
                  restartQuizz: mainScreenRef.levelTaped,
                ),
              );
            }
            break;
        }
        break;
      case Zones.foret:
        switch (miniGameOrder) {
          case 4:
            {
              blur = true;
              blur = true;
              mainScreen = QuizzGame(
                zone: zone,
                gameRef: Quizz(
                  hud: hud,
                  zone: zone,
                  level: miniGameOrder,
                  buildContext: context,
                  restartQuizz: mainScreenRef.levelTaped,
                ),
              );
            }
            break;
        }
        break;
      case Zones.mer:
        switch (miniGameOrder) {
          case 4:
            {
              blur = true;
              blur = true;
              mainScreen = QuizzGame(
                zone: zone,
                gameRef: Quizz(
                  hud: hud,
                  zone: zone,
                  level: miniGameOrder,
                  buildContext: context,
                  restartQuizz: mainScreenRef.levelTaped,
                ),
              );
            }
            break;
        }
        break;
    }

     **/

    blur = true;
    mainScreen = QuizzGame(
      zone: zone,
      gameRef: Quizz(
        hud: hud,
        zone: zone,
        level: miniGameOrder,
        buildContext: context,
        restartQuizz: mainScreenRef.levelTaped,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    getMainScreen(context);
    return Stack(
      children: [

        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImageUrl),
              fit: BoxFit.cover
            ),
          ),
        ),
        BackdropFilter(
          filter: blur ?  ImageFilter.blur(sigmaX: 2, sigmaY: 2) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: mainScreen,
        )
        ,
        hud,
      ],
    );
  }




}