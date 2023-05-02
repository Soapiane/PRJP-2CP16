

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';
import 'package:projet2cp/MiniGames/MiniGameMainScreen.dart';
import 'package:projet2cp/SplashScreen/SplashScreen.dart';
import 'package:projet2cp/Navigation/Zone/ZoneBody.dart';
import 'package:projet2cp/Navigation/Zones.dart';




class Level extends PointModel{
  late Widget widget;
  late double posX;
  late double posY;
  late bool completed, unlocked;
  late int stars, number;
  double dim;
  late BuildContext context;
  late String imageUrl = "assets/map_horizontal_point.png";
  late Zones zone;
  Function(bool unlocked, Zones zone, int order) onTap ;

  Level({required this.posX, required this.posY, required this.completed, required this.unlocked,
        required this.stars, required this.number, required this.context, this.dim = 50.0, required this.zone,
        required this.onTap}){

    super.width = 50.0;
    super.child = testWidget(number);


    if (!unlocked){
      imageUrl = "assets/locked_level.png";
    }



  }



  Widget testWidget(int order) {
    return InkWell(
      hoverColor: Colors.blue,
      onTap: (){onTap.call(unlocked, zone, number);},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imageUrl,
            fit: BoxFit.fitWidth,
            width: dim,
          ),
          Text("$number",
              style: const TextStyle(color: Colors.black, fontSize: 16))
        ],
      ),
    );

  }

  dynamic _levelTaped() async {
    if (unlocked){
      return await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)  => MiniGameMainScreen(miniGameOrder: number, zone: zone)
          )
      );
    }
  }


}