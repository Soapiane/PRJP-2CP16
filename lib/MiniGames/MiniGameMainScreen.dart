

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/MiniGames/MiniGameHUD.dart';
import 'package:projet2cp/MiniGames/TurningPipes/TurningPipes.dart';
import 'package:projet2cp/Zones.dart';

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
    game =  TurningPipes(hud: hud);
  }

  void getBackgroundImageUrl(){
    backgroundImageUrl = "assets/ville.png";
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