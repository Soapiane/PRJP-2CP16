

import 'dart:async';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'SolutionPipe.dart';
import 'Pipe.dart';

class TurningPipes extends MiniGame with HasTappables{

  late TiledComponent _mapComponent;
  late List<SolutionPipe> solutions = [];
  static const double tileSize = 61.0;
  late bool finished;


  TurningPipes({required super.hud}){

  }








  @override
  Color backgroundColor() => Colors.transparent;

  @override
  FutureOr<void> onLoad() async {


    finished = false;
    _mapComponent = await TiledComponent.load('TurningPipesVille.tmx', Vector2.all(tileSize));


    _mapComponent.center = size/2;


    loadPipes();




  }

  void loadPipes(){
    loadNormalPipes(true);
    loadNormalPipes(false);
    loadSolutionPipes();
  }






  void loadNormalPipes(bool locked){

    String src = "lockedPipes";
    if (!locked) src = "unlockedPipes";

    final objGroup = _mapComponent.tileMap.getLayer<ObjectGroup>(src);

    for (final obj in objGroup!.objects){
      add(Pipe(
          locked: locked,
          type: Type.values[int.parse(obj.class_)~/10],
          pipeAngle: Angle.values[int.parse(obj.class_)%10],
          pipeHeight: tileSize,
          pipeWidth: tileSize,
          posY: obj.y-tileSize/2+ _mapComponent.y,
          posX: obj.x+tileSize/2 + _mapComponent.x,
          onTurn: (){
            modifyPoints(points: -1);
          }
      ));


    }
  }

  void loadSolutionPipes(){


    final objGroup = _mapComponent.tileMap.getLayer<ObjectGroup>("solutionPipes");
    SolutionPipe solutionPipe;
    List<String> pipeSolutionsString;
    List<Angle> pipeSolutions;


    for (final obj in objGroup!.objects){

      pipeSolutionsString = obj.name.split(',');
      pipeSolutions = [];

      for (var solutionString in pipeSolutionsString){
        pipeSolutions.add(Angle.values.firstWhere((element) => element.name == solutionString));
      }

      solutionPipe = SolutionPipe(
          solutions: pipeSolutions,
          type: Type.values[int.parse(obj.class_)~/10],
          pipeAngle: Angle.values[int.parse(obj.class_)%10],
          pipeHeight: tileSize,
          pipeWidth: tileSize,
          posY: obj.y-tileSize/2+ _mapComponent.y,
          posX: obj.x+tileSize/2 + _mapComponent.x,
          onTurn: (){
            checkSolution();
            modifyPoints(points: 1);

          },
      );
      solutions.add(solutionPipe);
      add(solutionPipe);


    }

    print("Solution pipes count: " + solutions.length.toString());

  }

  void checkSolution(){
    finished = true;
    for (var pipe in solutions) {
      if (!pipe.isSolved()){
        finished = false;
        break;
      }
    }
    print("FINISHED: " + finished.toString());
    if (finished){
      onFinished();
    }
  }









  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

  }

}