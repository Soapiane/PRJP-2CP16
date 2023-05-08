import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';

import 'actors/player.dart';
import 'level/Level.dart';

class ArrangerVille extends MiniGame with HasCollisionDetection, TapDetector {
  late Image spriteTrash;
  late bool stop;
  late bool pause;
  late Image spriteEarth;
  late Image fixedLamp,
      organicTrash,
      organicCan,
      car,
      lamp,
      coin,
      leaf,
      plasticTrash,
      plasticCan,
      house,
      fixedHouse,
      fixedCar,
      paperTrash,
      paperCan,
      attention;
  late bool ActionChanged; //to check if the action changed
  late bool jumpInput;
  late bool hAxisInput;
  late Player player;
  late int MaxPoints;
  Level? currentLevel;
  late SpriteAnimation running;
  late SpriteAnimation jumping;
  late SpriteAnimation idle;


  ArrangerVille({required super.hud, required super.zone, required super.level, required super.challenge, required super.context}) {
    setInitStars(initStars: 0);
    switch (difficulty) {
      case Difficulty.EASY:
        MaxPoints = 124 + 80;
        break;
      case Difficulty.MEDIUM:
        MaxPoints = 151 + 12 * 10;
        break;
      case Difficulty.HARD:
        MaxPoints = 200 + 160;
        break;
      default:
        break;
    }
    setInitStars(initStars: 0);
    addPoints(maxPoints: MaxPoints);
  }
  @override
  void onRestart() {
    onLoad();
    super.onRestart();
  }

  @override
  void onLose() {
    super.onLose();
  }

  @override
  Future<void>? onLoad() async {
    ActionChanged = false;
    stop = false;
    pause = false;
    jumpInput = false;
    hAxisInput = false;

    //method to run asynchronous initialization code for the component here level
    await Flame.device.setLandscape(); //mode landscape for better visualisation
    await Flame.device.fullScreen(); //hide bar
    camera.viewport = FixedResolutionViewport(
        Vector2(960, 480)); //this will allow game to fit in screen

    //each variable here holds a specific sprite sheet

    spriteTrash = await images.load("Runner_Ville/ville.png");
    spriteEarth = await images.load("Runner_Ville/looking_curious.png");
    organicCan = await images.load("Runner_Ville/fixed_organic_trash.png");
    organicTrash = await images.load("Runner_Ville/organic_trash.png");
    coin = await images.load("Runner_Ville/coin.png");
    leaf = await images.load("Runner_Ville/leaf_coin.png");
    plasticTrash = await images.load('Runner_Ville/plastic_tash.png');
    plasticCan = await images.load("Runner_Ville/fixed_plastic_trash.png");
    car = await images.load("Runner_Ville/car.png");
    lamp = await images.load("Runner_Ville/lamp.png");
    house = await images.load("Runner_Ville/house.png");
    paperTrash = await images.load("Runner_Ville/paper_trash.png");
    fixedCar = await images.load("Runner_Ville/fixed_car.png");
    fixedLamp = await images.load("Runner_Ville/fixed_lamp.png");
    fixedHouse = await images.load("Runner_Ville/fixed_house.png");
    paperCan = await images.load("Runner_Ville/fixed_paper_trash.png");
    attention = await images.load("Runner_Ville/avertissement.png");
    //this is the animation for the player
    running = SpriteAnimation.spriteList(
        await fromJSONAtlas(
            'Runner_Ville/runningSheet.png', 'runningSheet.json'),
        stepTime: 0.1);
    jumping = SpriteAnimation.spriteList(
        await fromJSONAtlas(
            'Runner_Ville/jumpingSheet.png', 'jumpingSheet.json'),
        stepTime: 0.1);
    idle = SpriteAnimation.spriteList(
        await fromJSONAtlas('Runner_Ville/idleSheet.png', 'idleSheet.json'),
        stepTime: 0.1);

    loadLevel('LevelVille1.tmx');
    return super.onLoad();
  }

  void loadLevel(String levelName) {
    //method used to switch between levels
    currentLevel?.removeFromParent(); //remove previous level
    switch (difficulty) {
      case Difficulty.EASY:
        if (levelName == 'LevelVille2.tmx') {
          levelName = 'FinalVille.tmx';
        }
        break;
      case Difficulty.MEDIUM:
        if (levelName == 'LevelVille3.tmx') {
          levelName = 'FinalVille.tmx';
        }
        break;
      case Difficulty.HARD:
        break;
    }
    currentLevel = Level(levelName);
    add(currentLevel!); //displays it on screen
  }

  @override
  void onTapUp(TapUpInfo info) {
    if (info.eventPosition.game.x < 300) {
      hAxisInput = true;
    }

    jumpInput = true;

    super.onTapUp(info);
  }
}
