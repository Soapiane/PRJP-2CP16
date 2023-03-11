

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/TurningPipes/TurningPipes.dart';

class TurningPipesGame extends StatefulWidget {

  final Function? onFinished;

  TurningPipesGame({Key? key, this.onFinished}) : super(key: key);

  @override
  _TurningPipesState createState() => _TurningPipesState();

}


class _TurningPipesState extends State<TurningPipesGame>{

  late TurningPipes game;

  @override
  void initState() {
    super.initState();
    game = TurningPipes(
        onFinished: endLevel,
    );
  }

  void endLevel(){
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Congrats!!!"),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Thank you"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
          game: game,
    );
  }

}