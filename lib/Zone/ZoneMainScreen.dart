


import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/TurningPipes/TurningPipesGame.dart';
import 'package:projet2cp/Zone/Zones.dart';
import './Map/Zone.dart' as zoneModel;


class ZoneMainScreen extends StatefulWidget {

  final Zones zone;

  const ZoneMainScreen({super.key, required this.zone});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<ZoneMainScreen> createState() => _ZoneMainScreenState();
}

class _ZoneMainScreenState extends State<ZoneMainScreen> {

  late Widget? foreground;
  late String backgroundImageUrl;
  late List<double> yZone, xZone;

  @override
  void initState() {
    super.initState();

    _getBackgroundImageUrl();

    _getXYValues();
    foreground = zoneModel.Zone(zone: widget.zone,levelsNumber: 7, levelReached: 3, xValues: xZone, yValues: yZone);
  }

  void _getXYValues(){
    xZone = [275.47 , 415.31 , 758.82 , 1034.78 , 1315 , 1037.52 , 641.46 ];
    yZone = [ 583.4 , 351.05 , 283.32 , 144.2 , 427.67 , 724.45 , 869.04 ];
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