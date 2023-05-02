import 'dart:async';
import 'dart:ui';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'SolutionPipe.dart';
import 'Pipe.dart';

class TurningPipes extends MiniGame with HasTappables{


  late TiledComponent _mapComponent;
  late List<SolutionPipe> solutions = [];
  late List<Pipe> normals = [];
  static const double tileSize = 61.0;
  late bool finished;
  late int time;
  late Component background;
  late Pipe firstPipe;


  TurningPipes({required super.hud}){
    zone = Zones.ville;
    level = 0;
    challenge = 1;
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

    firstPipe = normals[0];
    for (Pipe pipe in normals){
      if (pipe.posX < firstPipe.posX){
        firstPipe = pipe;
      }
    }

    var image = await Flame.images.load('TurningPipes/background.png');

    background = SpriteComponent.fromImage(
      image,
      position: Vector2(firstPipe.posX - (tileSize/2), firstPipe.posY - tileSize),
      size: Vector2(8*tileSize, 4*tileSize),
    );
    add(background);




    loadPipesOnScreen();



    shufflePipes();
    onStart();


  }

  void loadPipesOnScreen(){
    for (var pipe in normals){
      add(pipe);
    }
    for (var pipe in solutions){
      add(pipe);
    }
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
      // add(normalPipe);


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
      // add(solutionPipe);


    }


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
    if (finished){
      onFinished();
    }
  }









  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // background.render(canvas, position: background.srcPosition, size: background.srcSize);
  }

  @override
  void update(double dt) {
    super.update(dt);

  }

}