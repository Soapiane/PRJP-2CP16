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

import '../../Navigation/Zones.dart';
import 'actors/player.dart';
import 'level/Level.dart';

class ArrangerForet extends MiniGame with HasCollisionDetection, TapDetector {
  late Image spriteTrash;
  late bool stop = false;
  late bool pause = false;
  late Image spriteEarth;
  late Image capturedRabbit,
      faucet,
      emptyPlant,
      fixedLamp,
      fixedFaucet,
      organicTrash,
      organicCan,
      uncapturedRabbit,
      unemptyPlant,
      coin,
      leaf,
      plasticTrash,
      plasticCan,
      attention;
  late bool ActionChanged = false;
  late bool jumpInput = false;
  late bool hAxisInput = false;
  late Player player;
  Level? currentLevel;
  late SpriteAnimation running;
  late SpriteAnimation jumping;
  late SpriteAnimation idle;
  late int MaxPoints = 0;
  ArrangerForet({required super.hud, required super.zone, required super.level, required super.challenge, required super.context}) {
    setInitStars(initStars: 0);
    switch (difficulty) {
      case Difficulty.EASY:
        MaxPoints = 128 + 70;
        break;
      case Difficulty.MEDIUM:
        MaxPoints = 159 + 120;
        break;
      case Difficulty.HARD:
        MaxPoints = 211 + 150;
        break;
      default:
        break;
    }
    addPoints(maxPoints: MaxPoints);
    setInitStars(initStars: 0);



  }



  @override
  void onRestart() {
    onLoad();

    super.onRestart();
  }

  @override
  void onLose() {
    // TODO: implement onLose
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
    spriteTrash = await images.load("Runner_Forest/foret.png");
    spriteEarth = await images.load("Runner_Forest/looking_curious.png");
    capturedRabbit = await images.load("Runner_Forest/captured_rabbit.png");
    emptyPlant = await images.load("Runner_Forest/plant_umpty.png");
    faucet = await images.load("Runner_Forest/tap.png");
    fixedFaucet = await images.load("Runner_Forest/fixed_tap.png");
    organicCan = await images.load("Runner_Forest/fixed_organic_trash.png");
    organicTrash = await images.load("Runner_Forest/organic_trash.png");
    uncapturedRabbit =
        await images.load("Runner_Forest/fixed_captured_rabbit.png");
    unemptyPlant = await images.load("Runner_Forest/fixed_plant_umpty.png");
    coin = await images.load("Runner_Forest/coin.png");
    leaf = await images.load("Runner_Forest/leaf_coin.png");
    plasticTrash = await images.load('Runner_Forest/plastic_tash.png');
    plasticCan = await images.load("Runner_Forest/fixed_plastic_trash.png");
    attention = await images.load("Runner_Forest/avertissement.png");

    //this is the animation for the player
    running = SpriteAnimation.spriteList(
        await fromJSONAtlas(
            'Runner_Forest/runningSheet.png', 'runningSheet.json'),
        stepTime: 0.1);
    jumping = SpriteAnimation.spriteList(
        await fromJSONAtlas(
            'Runner_Forest/jumpingSheet.png', 'jumpingSheet.json'),
        stepTime: 0.1);
    idle = SpriteAnimation.spriteList(
        await fromJSONAtlas('Runner_Forest/idleSheet.png', 'idleSheet.json'),
        stepTime: 0.1);

    loadLevel('LevelForet1.tmx');
    return super.onLoad();
  }

  @override
  void onMount() async {
    // TODO: implement onMount
    super.onMount();

    await Future.delayed(Duration(milliseconds: 100), () => showTutorial("assets/tutorials/runner_foret.png"));
  }

  void loadLevel(String levelName) {
    //method used to switch between levels
    currentLevel?.removeFromParent(); //remove previous level

    switch (difficulty) {
      case Difficulty.EASY:
        if (levelName == 'LevelForet2.tmx') {
          levelName = 'FinalForet.tmx';
        }
        break;
      case Difficulty.MEDIUM:
        if (levelName == 'LevelForet3.tmx') {
          levelName = 'FinalForet.tmx';
        }
        break;
      case Difficulty.HARD:
        break;
    }
    currentLevel = Level(levelName);
    add(currentLevel!); //displays it on screen


  }

  @override
  void onTapDown(TapDownInfo info) {
    if (info.eventPosition.game.x < 300) {
      hAxisInput = true;
    }

    jumpInput = true;

    super.onTapDown(info);
  }
}
