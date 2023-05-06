import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/MiniGames/Hud/ScoreScreen.dart';

import 'actors/player.dart';
import 'level/Level.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';

class ArrangerZone extends MiniGame with HasCollisionDetection, TapDetector {
  late Image spriteTrash;
  late bool stop = false;
  late bool pause = false;
  late Image spriteEarth;
  late int MaxPoints;
  late Image coin,
      leaf,
      plasticTrash,
      plasticCan,
      paperTrash,
      paperCan,
      brokenEolienne,
      fixedEolienne,
      fixedNuclearTrash,
      fixedPollutionFact,
      nuclearTrash,
      pollutingFact,
      attention;
  late bool ActionChanged = false;
  late bool jumpInput = false;
  late bool hAxisInput = false;
  late Player player;
  Level? currentLevel;
  late SpriteAnimation running;
  late SpriteAnimation jumping;
  late SpriteAnimation idle;

  ArrangerZone({required super.hud}) {
    setInitStars(initStars: 0);
    switch (difficulty) {
      case Difficulty.EASY:
        MaxPoints = 97;
        break;
      case Difficulty.MEDIUM:
        MaxPoints = 125;
        break;
      case Difficulty.HARD:
        MaxPoints = 223;
        break;
      default:
        break;
    }
    addPoints(maxPoints: MaxPoints);
    setInitStars(initStars: 0);
  }

  @override
  void onRestart() {
    super.onRestart();
    loadLevel("LevelZone1.tmx");
  }

  @override
  Future<void>? onLoad() async {
    //method to run asynchronous initialization code for the component here level
    await Flame.device.setLandscape(); //mode landscape for better visualisation
    await Flame.device.fullScreen(); //hide bar
    camera.viewport = FixedResolutionViewport(
        Vector2(960, 480)); //this will allow game to fit in screen

    //each variable here holds a specific sprite sheet

    spriteTrash = await images.load("Runner_Zone/foret.png");
    spriteEarth = await images.load("Runner_Zone/looking_curious.png");

    coin = await images.load("Runner_Zone/coin.png");
    leaf = await images.load("Runner_Zone/leaf_coin.png");
    plasticTrash = await images.load('Runner_Zone/plastic_tash.png');
    plasticCan = await images.load("Runner_Zone/fixed_plastic_trash.png");
    paperTrash = await images.load("Runner_Zone/paper_trash.png");
    paperCan = await images.load("Runner_Zone/fixed_paper_trash.png");
    paperCan = await images.load("Runner_Zone/fixed_paper_trash.png");
    brokenEolienne = await images.load("Runner_Zone/broken_eolienne.png");
    fixedEolienne = await images.load("Runner_Zone/fixed_broken_eolienne.png");
    attention = await images.load("Runner_Zone/avertissement.png");
    fixedNuclearTrash =
        await images.load("Runner_Zone/fixed_broken_eolienne.png");
    fixedPollutionFact =
        await images.load("Runner_Zone/fixed_polluting_factory.png");
    nuclearTrash = await images.load("Runner_Zone/nuclear_trash.png");
    pollutingFact = await images.load("Runner_Zone/polluting_factory.png");
    //this is the animation for the player
    running = SpriteAnimation.spriteList(
        await fromJSONAtlas(
            'Runner_Zone/runningSheet.png', 'runningSheet.json'),
        stepTime: 0.1);
    jumping = SpriteAnimation.spriteList(
        await fromJSONAtlas(
            'Runner_Zone/jumpingSheet.png', 'jumpingSheet.json'),
        stepTime: 0.1);
    idle = SpriteAnimation.spriteList(
        await fromJSONAtlas('Runner_Zone/idleSheet.png', 'idleSheet.json'),
        stepTime: 0.1);

    loadLevel('LevelZone1.tmx');
    return super.onLoad();
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
