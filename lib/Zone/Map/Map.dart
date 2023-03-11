//
//
// import 'package:flutter/widgets.dart';
// import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
// import 'package:game_levels_scrolling_map/model/point_model.dart';
// import 'package:projet2cp/Zone/Map/Level.dart';
//
// import 'Zone.dart';
//
// class Map extends StatefulWidget {
//
//
//   Map({super.key});
//
//
//
//   @override
//   State<StatefulWidget> createState() => _MapState();
//
// }
//
// class _MapState extends State<Map>{
//
//
//
//   List<Zone> zones = [];//list of the zones that the map contains
//   List<double> xValues = [];//x-axis coordinates for the map levels
//   List<double> yValues = [];//y-axis coordinates for the map levels
//   List<PointModel> points = [];//list of the points that will be drawn on the map, each point represents a level
//   String imageUrl = "";//the map background image
//   late Widget map;//the whole map the will be returned
//
//
//   //this will bu hugely modified when we start using sqlLite and Firebase
//   void _createZone(
//       {required List<double> xZone,
//        required List<double> yZone,
//        required int zoneNumber,
//        required int levelsNumber,
//         required int levelReached,
//        required bool unlocked}){
//
//     xValues = xValues+xZone;
//     yValues = yValues+yZone;
//     List<Level> levels = [];
//     int firstLevel = points.length + 1;
//
//     bool levelUnlocked = true;
//     bool levelCompleted = true;
//     for(int i=firstLevel;i<=firstLevel+levelsNumber-1;i++){
//       if(i==levelReached){levelCompleted = false;}
//       if(i==levelReached+1){levelUnlocked = false;}
//
//       Level level = Level(
//           posX: xZone[i-firstLevel],
//           posY: yZone[i-firstLevel],
//           completed: levelCompleted,
//           unlocked: levelUnlocked,
//           stars: 0,
//           number: i,
//           context: context,
//
//       );
//       levels.add(level);
//       if (unlocked) points.add(PointModel(level.dim, level.widget));
//     }
//
//     zones.add(
//       Zone(levels: levels, unlocked: unlocked, number: zoneNumber)
//     );
//
//   }
//
//   //in this function we'll put the code add any zone we wanna add
//   void _createZones(){
//
//     List<double> xZone;//x-axis coordinates for the map levels in the zone
//     List<double> yZone;//y-axis coordinates for the map levels in the zone
//     bool unlocked = true;
//
//
//
//     xZone = [275.47 , 415.31 , 758.82 , 1034.78 , 1315 , 1037.52 , 641.46 ];
//     yZone = [ 583.4 , 351.05 , 283.32 , 144.2 , 427.67 , 724.45 , 869.04 ];
//     _createZone(
//         xZone: xZone,
//         yZone: yZone,
//         zoneNumber: 1,
//         levelsNumber: 7,
//         levelReached: 5,
//         unlocked: unlocked
//     );
//     if (!zones[0].completed) unlocked = false;//if one zone is incomplete, the all the next zones will be locked
//
//
//     xZone = [ 1831.99 , 1976.55 , 2313.62 , 2587.27 , 2875.52 , 2588.78 , 2193.96];
//     yZone = [586.49 , 351.34 , 283.32 , 144.2 , 422.28 , 720.64 , 869.04];
//     _createZone(
//         xZone: xZone,
//         yZone: yZone,
//         zoneNumber: 2,
//         levelsNumber: 7,
//         levelReached: 7,
//         unlocked: unlocked
//     );
//     if (!zones[1].completed) unlocked = false;
//
//
//
//   }
//
//   void _getImageUrl(){
//
//
//     imageUrl = 'assets/test_map_long.png';//for now, the map image is fixed
//     //TODO: -add logic to change the image based on the screen density (or size) and zone state (locked state and progress)
//   }
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _createZones();
//
//     _getImageUrl();
//
//
//
//
//     map = GameLevelsScrollingMap.scrollable(
//       imageUrl: imageUrl,
//       x_values: xValues,
//       y_values: yValues,
//       points: points,
//     );
//
//
//   }
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//     return map;
//   }
//
//
// }