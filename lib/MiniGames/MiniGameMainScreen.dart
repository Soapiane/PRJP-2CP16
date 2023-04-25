

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


  MiniGameMainScreen({super.key,required this.miniGameOrder,  required this.zone}){
    getBackgroundImageUrl();
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

  void getBackgroundImageUrl(){
    //the background image is based on the zone
    switch (zone) {
      case Zones.ville:
        backgroundImageUrl = "assets/ville.png";
        break;
      default:
        backgroundImageUrl = "assets/ville.png";
        break;
    }
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
        GameWidget(game: game),
        hud,
      ],
    );
  }




}