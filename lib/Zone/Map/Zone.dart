

import 'package:flutter/cupertino.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:projet2cp/Zone/Map/Level.dart';
import 'package:projet2cp/Zones.dart';

class Zone extends StatefulWidget {
  late int levelsNumber;
  late int stars, maxStars, levelReached;
  List<double> xValues;
  List<double> yValues;
  Zones zone;


  Zone({super.key, required this.zone ,required this.levelsNumber, required this.levelReached, required this.xValues, required this.yValues}){

    maxStars = 3*levelsNumber;

    stars = 0;





  }

  @override
  State<StatefulWidget> createState() => _ZoneState();






}



class _ZoneState extends State<Zone>{


  bool levelUnlocked = true;
  bool levelCompleted = true;
  late Level level;
  List<Level> levels = [];
  late Widget map;//the whole map the will be returned

  @override
  void initState() {
    super.initState();


    for(int i=1;i<=widget.levelsNumber;i++){
      if(i==widget.levelReached){levelCompleted = false;}
      if(i==widget.levelReached+1){levelUnlocked = false;}

        level = Level(
          zone: widget.zone,
          posX: widget.xValues[i-1],
          posY: widget.yValues[i-1],
          completed: levelCompleted,
          unlocked: levelUnlocked,
          stars: 0,
          number: i,
          context: context,

      );

      levels.add(level);

    }

    map = GameLevelsScrollingMap.scrollable(
      imageUrl: "assets/transparent.png" ,
      x_values: widget.xValues,
      y_values: widget.yValues,
      points: levels,
    );






  }


  @override
  Widget build(BuildContext context) {
    return map;
  }

}