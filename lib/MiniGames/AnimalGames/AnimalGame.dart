
import 'dart:async';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import '../../Navigation/Zones.dart';
import 'Animal.dart';
import 'TrashSpawner.dart';
class AnimalGame extends MiniGame with HasDraggableComponents,HasCollisionDetection{
  late Animal animal;
  bool Started=false;
  bool theEnd=false;
  late SpriteAnimation animation;
  late double time_of_the_game=60;
  late Timer timer=Timer(time_of_the_game,onTick:EndIt,repeat: false);

  AnimalGame({required super.zone, required super.hud, required super.context, required super.level, required super.challenge}) {
    setPointsAsset(asset: "assets/images/AnimalGames/images/heart.svg");
    setPointsString(name: "coeur");
    addPoints(maxPoints:3);
    hud.useBar=true;
    timer.start();
  }
  late TrashSpawner _trashSpawner;
  late ParallaxComponent _parallax,parallaxComponent;
  late Images images_jeu;
  late double score=0;
  late TextPaint _scoreText=TextPaint(style: const TextStyle(color: Colors.black,fontSize: 25));
  late Vector2 Vector=Vector2(20, 0);
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    Flame.device.fullScreen();
    Flame.device.setLandscape();
    animal = Animal(size2: size,gameRef: this);
    animal
      ..size = Vector2(80,64)
      ..position = Vector2(0, size[1] / 2 - 32);
    if(zone==Zones.mer){
      final spritesTurtle = [1, 2, 3, 4, 5,6,7,8]
          .map((i) => Sprite.load('AnimalGames/images/turtle/tortue$i.png'));
       animation = SpriteAnimation.spriteList(
        await Future.wait(spritesTurtle),
        stepTime: 0.15,
      );
      animal..animation=animation;
      _parallax = await ParallaxComponent.load(
        [
          ParallaxImageData('AnimalGames/images/layersTurtle/1.png'),
          ParallaxImageData('AnimalGames/images/layersTurtle/2.png'),
          ParallaxImageData('AnimalGames/images/layersTurtle/3.png'),
          ParallaxImageData('AnimalGames/images/layersTurtle/4.png'),
          ParallaxImageData('AnimalGames/images/layersTurtle/5.png'),
          ParallaxImageData('AnimalGames/images/layersTurtle/6.png'),

        ],
        repeat: ImageRepeat.repeat,
        baseVelocity: Vector,
        velocityMultiplierDelta: Vector2(1.5, 0),
      );
    }else{
      final spritesBird = [1, 2, 3, 4, 5,6,7,8,9]
          .map((i) => Sprite.load('AnimalGames/images/Bird/bird$i.png'));
      animation = SpriteAnimation.spriteList(
        await Future.wait(spritesBird),
        stepTime: 0.1,
      );
      animal..animation=animation;
      _parallax = await ParallaxComponent.load(
        [
          ParallaxImageData('AnimalGames/images/layersBird/1.png'),
          ParallaxImageData('AnimalGames/images/layersBird/2.png'),
          ParallaxImageData('AnimalGames/images/layersBird/4.png'),
          ParallaxImageData('AnimalGames/images/layersBird/5.png'),
        ],

        repeat: ImageRepeat.repeat,
        baseVelocity: Vector2.zero(),
        velocityMultiplierDelta: Vector2(1.5, 0),
      );

    }
    //backgro
    _trashSpawner = TrashSpawner(
        sprites: images, size2: size, gameRef: this);
    parallaxComponent=_parallax;
    add(animal);
    add(_parallax);


    showTutorial(zone == Zones.foret ? "assets/tutorials/bird.png" : "assets/tutorials/turtle.png");
  }



  void onBegin(){
    Started=true;
    add(_trashSpawner);
    _parallax.parallax?.baseVelocity.setValues(20,0);

  }

  @override
  FutureOr<void> showTutorial(String? path) async {
    // TODO: implement showTutorial
    await super.showTutorial(path);
    onBegin();
  }





  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if(Started){
      if(!theEnd) {
        score+=60*dt;
        timer.update(dt);
      }else{
        _parallax.parallax?.baseVelocity.setZero();
        animal.x+=size[0]/5*dt;
        if(animal.x>size[0]){
          theEnd=false;
          animal.removeFromParent();
          onFinished();
          //ADD END SCREEN
        }
      }
    }

  }
  void EndIt(){
    theEnd=true;
  }
  @override
  void onRestart() {
    // TODO: implement onRestart
    super.onRestart();
    theEnd=false;
    animal.removeFromParent();
    timer.stop();
    timer.start();
    _trashSpawner.removeFromParent();
    animal=new Animal(size2: size, gameRef: this);
    _trashSpawner = new TrashSpawner(
        sprites: images, size2: size, gameRef: this);
    add(_trashSpawner);
    _parallax.parallax?.baseVelocity.setValues(20,0);
    score=0;
    add(animal
      ..size = Vector2(size[1]/6*1.25,size[1]/6)
      ..animation= animation
      ..position = Vector2(0, size[1] / 2 - size[1]/12));
  }
}
