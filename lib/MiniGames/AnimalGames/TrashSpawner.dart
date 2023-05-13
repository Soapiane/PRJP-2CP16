import 'package:flame/cache.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'dart:math';
import '../../Navigation/Zones.dart';
import 'Trash.dart';
import 'AnimalGame.dart';
class TrashSpawner extends Component with HasGameRef{
  // The timer which runs the enemy spawner code at regular interval of time.
  late Timer _timer;
  late Trash _trash;
  late Vector2 size2;
  late Vector2 positionOfTrash;
  // Controls for how long EnemyManager should stop spawning new enemies.
  late Timer _freezeTimer;
  late Images sprites;
  late int Rand;
  late int Rand_Positioning;
  late double randomDouble ;
  final double trashSize =40;
  late int Y;
  final int min=0;
  late int spawnLevel;
  late double Speed;
  late double Temps;
  late Vector2 size3;
  late final AnimalGame gameRef;
  TrashSpawner({required this.sprites,required this.size2,required this.gameRef}):super(){
    spawnLevel=0;
    if(gameRef.difficulty==Difficulty.EASY){
      Speed=200;
      Temps=3;
    }else{
      if(gameRef.difficulty==Difficulty.MEDIUM){
        Speed=300;
        Temps=2;
      }else{
        Speed=400;
        Temps=1;
      }
    }
    _timer = Timer(Temps, onTick: _spawnTrash, repeat: true);
    // Sets freeze time to 2 seconds. After 2 seconds spawn timer will start again.
    _freezeTimer = Timer(1, onTick: () {
      _timer.start();
    });
  }
  @override
  void onMount() {
    super.onMount();
    // Start the timer as soon as current enemy manager get prepared
    // and added to the game instance.
    gameRef.modifyPoints(points: 3);
    gameRef.setStars(stars: 3);
    _spawnTrash();
    _timer.start();
  }
  @override
  void update(double dt) {
    super.update(dt);
    // Update timers with delta time to make them tick.
    if(!gameRef.theEnd){
      _timer.update(dt);
      _freezeTimer.update(dt);
      var newspawnlevel=(gameRef.score~/500);
      if(spawnLevel<newspawnlevel){
        spawnLevel=newspawnlevel;
        Speed=Speed*(1.1);
        Temps=Temps/1.05;

        _timer.stop();
        _timer.start();


      }
    }else{
      _timer.stop();
    }

  }
  void _spawnTrash(){
    Random random = Random();
    Rand_Positioning =  Random().nextInt(2) ;

    int NbTrash;
    if(gameRef.zone==Zones.mer){
      NbTrash=5;
    }else{
      NbTrash=5;
    }
    Rand = random.nextInt(NbTrash)+1;
    if(gameRef.zone==Zones.mer){

      if(Rand==1){
        size3 =
            Vector2.all(gameRef.size[1] *50/400);
      }else{
        if(Rand==2){
          size3 =
              Vector2.all(gameRef.size[1] *40/400);
        }else{
          if(Rand==3){
            size3 =
                Vector2((gameRef.size[1] *100/400)*500/445, gameRef.size[1] *100/400);

          }else{
            if(Rand==4){
              size3 =
                  Vector2( (gameRef.size[1] * 30 / 164)*783/661, gameRef.size[1] * 30 / 164);
            }else{
              size3=Vector2.all(gameRef.size[1] *50/400);
            }
          }
        }
      }
        randomDouble = min + Random().nextDouble() * ((size2[1]-trashSize) -min);
      if(Rand_Positioning==0){
        positionOfTrash=Vector2(size2[0], randomDouble);
      }else{
        positionOfTrash=Vector2(size2[0], gameRef.animal.y);
      }
      _trash=Trash(size2: size2,Speed: Speed);
      _trash..sprite=Sprite(sprites.fromCache('AnimalGames/images/trashTurtle/trash${Rand}.png'))
        ..position=positionOfTrash..size=size3;
      add(_trash);
    }else {
      if (Rand == 1) {
        size3 =
            Vector2(gameRef.size[0] * 17.74 / 220, gameRef.size[1] * 31 / 164);
      } else {
        if (Rand == 2) {
          size3 =
              Vector2(gameRef.size[0] * 64 / 220, gameRef.size[1] * 21 / 164);
        } else {
          if (Rand == 3) {
            size3 =
                Vector2(gameRef.size[0] * 20 / 220, gameRef.size[1] * 40 / 164);
          } else {
            if (Rand == 4) {
              size3 = Vector2(
                  gameRef.size[0] * 20 / 220, gameRef.size[1] * 40 / 164);
            }else{
              size3=Vector2.all(gameRef.size[1] *50/400);

            }
          }
        }
      }

      randomDouble = min + Random().nextDouble() * ((size2[1]-size3[1]) -min);
      if(Rand_Positioning==0){
        positionOfTrash=Vector2(size2[0], randomDouble);
      }else{
        positionOfTrash=Vector2(size2[0], gameRef.animal.y);

      }
      _trash = Trash(size2: size3, Speed: Speed);
      _trash
        ..sprite = Sprite(sprites.fromCache('AnimalGames/images/trashBird/trash${Rand}.png'))
        ..position = positionOfTrash
        ..size = size3;
      add(_trash);
    }
  }
}