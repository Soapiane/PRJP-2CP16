

import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/MiniGames/Hud/MiniGameHUD.dart';
import 'package:projet2cp/MiniGames/TurningPipes/TurningPipes.dart';
import 'package:projet2cp/Navigation/Zones.dart';

class MiniGameMainScreen extends StatelessWidget {

  final int miniGameOrder;
  late MiniGame game;
  late MiniGameHUD hud;
  final Zones zone;
  late String backgroundImageUrl;
  bool blur = false;


  MiniGameMainScreen({super.key,required this.miniGameOrder,  required this.zone}){
    backgroundImageUrl = zone.backgroundImagePath;
    getHUD();
    getMiniGame();
  }

  void getHUD(){
    hud = MiniGameHUD(
      zone: zone,
    );
  }



  void getMiniGame(){
    //chose the game based on the zone and the order
    switch (zone) {
      case Zones.ville:
        switch (miniGameOrder) {
          case 1:
            blur = true;
            game = TurningPipes(hud: hud);
            break;
          default:
            game = TurningPipes(hud: hud);
            break;
        }
        break;
      default:
        game = TurningPipes(hud: hud);
        break;
    }
    game =  TurningPipes(hud: hud);
  }


  @override
  Widget build(BuildContext context) {
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
          child: GameWidget(game: game),
        )
        ,
        hud,
      ],
    );
  }




}