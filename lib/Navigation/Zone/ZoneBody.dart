


import 'package:flutter/material.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'Map/Zone.dart' as zoneModel;


class ZoneBody extends Body {

  final Zones zone;


  late Widget? foreground;
  late String backgroundImageUrl;
  late List<double> yZone, xZone;
  Function(bool unlocked, Zones zone, int order) onTap ;


  ZoneBody({super.key, required this.onTap, required this.zone}){


    _getBackgroundImageUrl();

    _getXYValues();
    foreground = zoneModel.Zone(onTap: onTap, zone: zone,levelsNumber: 7, levelReached: 3, xValues: xZone, yValues: yZone);
  }


  void _getXYValues(){
    xZone = [175.021  , 903.0769  , 1768.5874  , 2463.4126  , 3280.5874  , 4250.3217  , 5154.0981  ];
    yZone = [ 780.2238  , 406.6294  , 849.2028  , 334.1259 ,  846.1818  , 403.6084  , 876.3916  ];
  }

  void _getBackgroundImageUrl(){
    backgroundImageUrl = "assets/ville.png";
  }


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundImageUrl),
              fit: BoxFit.cover
          ),
        ),
        child: foreground,
      ),
    );


  }




}
