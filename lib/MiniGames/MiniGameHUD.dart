


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Zone/Zones.dart';

class MiniGameHUD extends StatefulWidget{

  Zones zone;


  MiniGameHUD(this.zone);

  @override
  State<StatefulWidget> createState() => _MiniGameHUDState();


}


class _MiniGameHUDState extends State<MiniGameHUD>{
  @override
  Widget build(BuildContext context) {
    return Text(
      "hi",
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }
  
}