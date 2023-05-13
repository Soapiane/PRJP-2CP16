

import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/MainScreen.dart';
import 'package:projet2cp/MiniGames/AnimalGames/AnimalGame.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/MiniGames/Hud/MiniGameHUD.dart';
import 'package:projet2cp/MiniGames/Puzzle/Choice_Menu.dart';
import 'package:projet2cp/MiniGames/Puzzle/PuzzleGame.dart';
import 'package:projet2cp/MiniGames/Quizz/Quizz.dart';
import 'package:projet2cp/MiniGames/Quizz/quizzGame.dart';
import 'package:projet2cp/MiniGames/Recycler/RecyclerGame.dart';
import 'package:projet2cp/MiniGames/RunnerForest/game.dart';
import 'package:projet2cp/MiniGames/RunnerVille/game.dart';
import 'package:projet2cp/MiniGames/TurningPipes/TurningPipes.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/MiniGames/RunnerZoneIndustrielle/game.dart';

class MiniGameMainScreen extends StatelessWidget {

  final int miniGameOrder;
  late MiniGameHUD hud;
  final Zones zone;
  late String backgroundImageUrl;
  late Widget mainScreen = SizedBox.shrink();
  bool blur = false;
  MainState mainScreenRef;
  bool restart;



  MiniGameMainScreen({super.key,required this.miniGameOrder,  required this.zone, required this.mainScreenRef,required this.restart}){
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

    switch (zone) {
      case Zones.ville:
        switch (miniGameOrder) {
          case 1:
            {
              blur = true;
              mainScreen = GameWidget(game: TurningPipes(hud: hud, context: context,
                zone: zone,
                level: miniGameOrder-1,
                challenge: 1,));
            }
            break;
          case 2:
            {
              blur = true;
              mainScreen = GameWidget(game: ArrangerVille(
                hud: hud,
                zone: zone,
                level: miniGameOrder-1,
                context: context,
                challenge: 2,
              ));
            }
            break;
          case 3:
            {
        blur = true;
        mainScreen = GameWidget(game: Recycler(
        hud: hud,
        zone: zone,
        level: miniGameOrder-1,
        context: context,
          challenge: 3,
        ));
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
                  level: miniGameOrder-1,
                  context: context,
                  restartQuizz: mainScreenRef.levelTaped,
                  challenge: 4,
                  restart: restart!,
                ),
              );
            }
            break;
        }
        break;
      case Zones.zoneIndustrielle:
        switch (miniGameOrder) {

          case 1:
            {
              blur = true;
              mainScreen = GameWidget(game: ArrangerZone(
                hud: hud,
                zone: zone,
                level: miniGameOrder-1,
                context: context,
                challenge: 9,
              ));
            }
            break;
          case 2:
            {
              blur = true;
              mainScreen = GameWidget(game: Recycler(
                hud: hud,
                zone: zone,
                level: miniGameOrder-1,
                context: context,
                challenge: 10,
              ));
            }
            break;
          case 3:
            {
              blur = true;
              final game = PuzzleGame(hud: hud, zone: zone, level: miniGameOrder-1, context: context, challenge: 11,);
              mainScreen = WillPopScope(
                  onWillPop: () async => false,
                  child: GameWidget(game: game,
                    overlayBuilderMap: {
                      PuzzleChoice.id: (BuildContext context, MiniGame gameRef) =>
                          PuzzleChoice(gameRef: game,),
                    },)
              );
            }
            break;
          case 4:
            {
              blur = true;
              blur = true;
              mainScreen = QuizzGame(
                zone: zone,
                gameRef: Quizz(
                  hud: hud,
                  zone: zone,
                  level: miniGameOrder-1,
                  context: context,
                  restartQuizz: mainScreenRef.levelTaped,
                  challenge: 12,
                  restart: restart!,
                ),
              );
            }
            break;
        }
        break;
      case Zones.foret:
        switch (miniGameOrder) {
          case 1:
            {
              blur = true;
              mainScreen = GameWidget(game: ArrangerForet(
                hud: hud,
                zone: zone,
                level: miniGameOrder-1,
                context: context,
                challenge: 5,
              ));
            }
            break;
          case 2:
            {
              blur = true;
              mainScreen = GameWidget(game: Recycler(
                hud: hud,
                zone: zone,
                level: miniGameOrder-1,
                context: context,
                challenge: 6,
              ));
            }
            break;
          case 3:
            {
              blur = true;
              mainScreen = GameWidget(game: AnimalGame(
                hud: hud,
                zone: zone,
                level: miniGameOrder-1,
                context: context,
                challenge: 7,
              ));
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
                  level: miniGameOrder-1,
                  context: context,
                  restartQuizz: mainScreenRef.levelTaped,
                  challenge: 8,
                  restart: restart!,
                ),
              );
            }
            break;

        }
        break;
      case Zones.mer:
        switch (miniGameOrder) {

          case 1:
            {
              blur = true;
              mainScreen = GameWidget(
                game: AnimalGame(
                  zone: zone,
                  hud: hud,
                  level: miniGameOrder-1,
                  context: context,
                  challenge: 13,
                ),
              );
            }
            break;
          case 2:
            {
              blur = true;
              mainScreen = GameWidget(game: Recycler(
                hud: hud,
                zone: zone,
                level: miniGameOrder-1,
                context: context,
                challenge: 14,
              ));
            }
            break;
          case 3:
            {
              blur = true;
              final game = PuzzleGame(hud: hud, zone: zone, level: miniGameOrder-1, context: context, challenge: 15,);
              mainScreen = WillPopScope(
                  onWillPop: () async => false,
                  child: GameWidget(game: game,
                    overlayBuilderMap: {
                      PuzzleChoice.id: (BuildContext context, MiniGame gameRef) =>
                          PuzzleChoice(gameRef: game,),
                    },)
              );
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
                  level: miniGameOrder-1,
                  challenge: 16,
                  context: context,
                  restartQuizz: mainScreenRef.levelTaped,
                  restart: restart!,
                ),
              );
            }
            break;
        }
        break;
      case Zones.alea:{

        blur = true;
        mainScreen = QuizzGame(
          zone: zone,
          gameRef: Quizz(
            hud: hud,
            zone: zone,
            level: miniGameOrder-1,
            context: context,
            restartQuizz: mainScreenRef.levelTaped,
            restart: restart!,
          ),
        );
      }
        break;
    }



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