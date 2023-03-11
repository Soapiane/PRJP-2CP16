

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/MiniGameHUD.dart';
import 'package:projet2cp/MiniGames/TurningPipes/TurningPipesGame.dart';
import 'package:projet2cp/Zone/Zones.dart';

class MiniGameMainScreen extends StatelessWidget {

  final int miniGameOrder;
  late Widget game;
  final Zones zone;
  late String backgroundImageUrl;


  MiniGameMainScreen({super.key,required this.miniGameOrder,  required this.zone}){
    getBackgroundImageUrl();
    getMiniGame();
  }

  void getMiniGame(){
    game = const TurningPipesGame();
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
        MiniGameHUD(zone),
        game,
      ],
    );
  }




}