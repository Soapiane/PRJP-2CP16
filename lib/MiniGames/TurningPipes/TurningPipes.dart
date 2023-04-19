

import 'dart:async';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Difficulty.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'SolutionPipe.dart';
import 'Pipe.dart';

class TurningPipes extends MiniGame with HasTappables{


  late TiledComponent _mapComponent;
  late List<SolutionPipe> solutions = [];
  late List<Pipe> normals = [];
  static const double tileSize = 61.0;
  late bool finished;
  late int time;


  TurningPipes({required super.hud}){
    switch (difficulty){
      case Difficulty.EASY:
        time = 60;
        break;
      case Difficulty.MEDIUM:
        time = 30;
        break;
      case Difficulty.HARD:
        time = 15;
        break;
    }
    addTimer(seconds: time);
    setInitStars(initStars: 3);

  }




  @override
  void onRestart() {
    shufflePipes();
    super.onRestart();
  }

  @override
  void onTimeUpdate(Duration duration) {
    // TODO: implement onTimeUpdate
    super.onTimeUpdate(duration);
    if(duration.inSeconds < 0){
      setStars(stars: 0);
    } else if(duration.inSeconds < time/4){
      setStars(stars: 1);
    } else if (duration.inSeconds < time/2){
      setStars(stars: 2);
    }


  }

  @override
  void onTimeOut() {
    // TODO: implement onTimeOut
    super.onTimeOut();
    setStars(stars: 0);
  }





  @override
  Color backgroundColor() => Colors.transparent;

  @override
  FutureOr<void> onLoad() async {


    finished = false;
    _mapComponent = await TiledComponent.load('TurningPipesVille.tmx', Vector2.all(tileSize));


    _mapComponent.center = size/2;


    loadPipes();


    shufflePipes();
    onStart();


  }

  void loadPipes(){
    loadNormalPipes(true);
    loadNormalPipes(false);
    loadSolutionPipes();
  }







  void loadNormalPipes(bool locked){

    String src = "lockedPipes";
    if (!locked) src = "unlockedPipes";

    Pipe normalPipe;

    final objGroup = _mapComponent.tileMap.getLayer<ObjectGroup>(src);

    for (final obj in objGroup!.objects){
      normalPipe = Pipe(
          locked: locked,
          type: Type.values[int.parse(obj.class_)~/10],
          pipeAngle: Angle.values[int.parse(obj.class_)%10],
          pipeHeight: tileSize,
          pipeWidth: tileSize,
          posY: obj.y-tileSize/2+ _mapComponent.y,
          posX: obj.x+tileSize/2 + _mapComponent.x,
          onTurn: (){
          }
      );
      normals.add(normalPipe);
      add(normalPipe);


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

          },
      );
      solutions.add(solutionPipe);
      add(solutionPipe);


    }

    print("Solution pipes count: " + solutions.length.toString());

  }


  void shufflePipes(){
    for (var pipe in normals){
      pipe.shuffle();
    }
    for (var pipe in solutions){
      pipe.shuffle();
    }
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