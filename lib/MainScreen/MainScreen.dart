


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/image.dart';
import 'dart:ui' as ui;
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<PointModel> points = [];
  int dim = 50;
  Widget? map;

  Widget testWidget(int order) {
    return InkWell(
      hoverColor: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/map_horizontal_point.png",
            fit: BoxFit.fitWidth,
            width: dim.toDouble(),
          ),
          Text("$order",
              style: const TextStyle(color: Colors.black, fontSize: 16))
        ],
      ),
      onTap: () {
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Point $order"),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
      },
    );

  }


  @override
  void initState() {
    super.initState();





    for(int i = 0; i<14 ; i++){
      PointModel point =  PointModel(dim.toDouble(),testWidget(i));


      points.add(point);

    }

    map = GameLevelsScrollingMap.scrollable(
      imageUrl: 'assets/test_map_long.png',
      svgUrl: 'assets/map_horizontal.svg',
      points: points,
    );
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Container(
          child: map,
        ),
    );


  }
}