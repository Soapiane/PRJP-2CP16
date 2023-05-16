import 'dart:io';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/src/game/flame_game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart';
import 'package:projet2cp/MiniGames/RunnerForest/actors/Attention.dart';

import '../actions/OrganicTrash.dart';
import '../actions/PlasticCan.dart';
import '../actions/capturedRabbit.dart';
import '../actions/emptyPlant.dart';
import '../actions/fixedFaucet.dart';
import '../actions/leaf.dart';
import '../actions/organicCan.dart';
import '../actions/plasticTrash.dart';
import '../actions/uncapturedRabbit.dart';
import '../actions/unemptyPlant.dart';
import '../actors/earth.dart';
import '../actors/pause.dart';
import '../actors/player.dart';
import '../actions/faucet.dart';
import '../actors/platform.dart';
import '../actors/position.dart';
import '../actors/wall.dart';
import '../game.dart';

import '../actors/trash.dart';
import '../actors/coin.dart';

class Level extends Component with HasGameRef<ArrangerForet> {
  final String levelName;
  Rect levelBounds = Rect.zero;
  Level(this.levelName) : super();

  @override
  Future<void>? onLoad() async {
    final level = await TiledComponent.load(
        levelName,
        Vector2.all(
            32)); //Map with name levelName of 32px tiles appears on screen
    gameRef.player = Player(levelBounds: levelBounds);
    gameRef.player
      ..animation = gameRef.idle
      ..size = Vector2(130, 130)
      ..anchor = Anchor.center
      ..priority = 3;
    add(level);
    levelBounds = Rect.fromLTWH(
      0,
      0,
      level.tileMap.map.width * level.tileMap.map.tileWidth.toDouble(),
      level.tileMap.map.height * level.tileMap.map.tileHeight.toDouble(),
    );
    gameRef.camera.followComponent(gameRef.player, worldBounds: levelBounds);

    spawnComponents(level.tileMap);
    return super.onLoad();
  }

  void spawnComponents(RenderableTiledMap tiledMap) {
    //The actions folder represent the actions that the player can do in the game, like picking up trash, or planting, or saving the rabbits
    //the actors folder represent the actors that are in the game, like the player, the platforms, the walls, the pause that makes him lose, the earth, the trash, the coins, the attention signs
    /*In this method we get from the tiledMap each group of objects {Platforms, SpawnCopmponents} and for each one of them, 
    we retreive the objects propretties their size, position, priority from the TiledMap and call the constructor for each one of them, 
    with these attributes and the sprite sheet where the spritee propreties are in the class of the object */

    final platformsLayer = tiledMap.getLayer<ObjectGroup>('Platforms');
    for (final platformObject in platformsLayer!.objects) {
      final platform = Platform(
        position: Vector2(platformObject.x, platformObject.y),
        size: Vector2(platformObject.width, platformObject.height),
      );
      add(platform);
    }

    final spawnComponents = tiledMap.getLayer<ObjectGroup>('SpawnComponents');
    for (final spawnComponent in spawnComponents!.objects) {
      //used to get the players position
      final position =
          Vector2(spawnComponent.x, spawnComponent.y - spawnComponent.height);
      final size = Vector2(spawnComponent.width, spawnComponent.height);
      final angle = spawnComponent.rotation;
      switch (spawnComponent.type) {
        //Attention
        case 'Attention':
          final attention = Attention(gameRef.attention,
              position: position, size: size, angle: angle);
          add(attention);
          break;
        //Trash
        case 'GreenBottle':
          final glassBottle = Trash(gameRef.spriteTrash,
              position: Vector2(spawnComponent.x, spawnComponent.y),
              size: size,
              angle: angle,
              x: 3,
              y: 2);
          add(glassBottle);
          break;
        case 'Cup':
          final cup = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 0, y: 1);
          add(cup);
          break;

        case 'Bottle':
          final bottle = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 0, y: 2);
          add(bottle);
          break;

        case 'WaterMelon':
          final waterMelon = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 1, y: 0);
          add(waterMelon);
          break;
        case 'Apple':
          final apple = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 2, y: 0);
          add(apple);
          break;
        case 'Coin':
          final coin = Coin(gameRef.coin, position: position, size: size);
          add(coin);
          break;
        case 'Leaf':
          final leaf = Leaf(gameRef.leaf, position: position, size: size);
          add(leaf);
          break;

        case 'Chicken':
          final chicken = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 4, y: 0);
          add(chicken);
          break;
        case 'Yaourt':
          final yaourt = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 1, y: 2);
          add(yaourt);
          break;

        //Actions

        case 'Faucet':
          final faucet = Faucet(gameRef.faucet,
              position: position, size: size, priority: 1);
          add(faucet);
          break;

        case 'CapturedRabbit':
          final rabbit = CapturedRabbit(gameRef.capturedRabbit,
              position: position, size: size, priority: 1);
          add(rabbit);
          break;

        case 'EmptyPlant':
          final plant = EmptyPlant(gameRef.emptyPlant,
              position: position, size: size, priority: 1);
          add(plant);
          break;
        case 'OrganicTrash':
          final trash = OrganicTrash(gameRef.organicTrash,
              position: position, size: size, priority: 1);
          add(trash);
          break;
        case 'PlasticTrash':
          final trash = PlasticTrash(gameRef.plasticTrash,
              position: position, size: size, priority: 1);
          add(trash);
          break;

        //Fixed Actions
        case 'PlasticCan':
          final plasticCan = PlasticCan(gameRef.plasticCan,
              position: position, size: size, priority: 2);
          add(plasticCan);
          break;
        case 'FixedFaucet':
          final fixedFaucet = FixedFaucet(gameRef.fixedFaucet,
              position: position, size: size, priority: 2);
          add(fixedFaucet);
          break;

        case 'UncapturedRabbit':
          final rabbit = UncapturedRabbit(gameRef.uncapturedRabbit,
              position: position, size: size, priority: 2);
          add(rabbit);
          break;

        case 'UnemptyPlant':
          final plant = UnemptyPlant(gameRef.unemptyPlant,
              position: position, size: size, priority: 2);
          add(plant);
          break;
        case 'OrganicCan':
          final trash = OrganicCan(gameRef.organicCan,
              position: position, size: size, priority: 2);
          add(trash);
          break;

        //This last object will be used as an entrance to the next TileMap
        case 'Wall':
          final wall = Wall(
              position: Vector2(spawnComponent.x, spawnComponent.y),
              size: Vector2(spawnComponent.width, spawnComponent.height),
              onEarthEnter: () {
                gameRef.loadLevel(
                    spawnComponent.properties.first.value.toString());
              });
          add(wall);

          break;
        //Player position
        case 'position':
          final playerPosition = PlayerPosition(
            position: Vector2(spawnComponent.x, spawnComponent.y),
            size: Vector2(spawnComponent.width, spawnComponent.height),
          );
          gameRef.player.position = playerPosition.position;
          (gameRef.player).removeFromParent();
          add(gameRef.player);
          break;
        case 'Earth':
          final earth = Earth(
            gameRef.spriteEarth,
            position: position,
            size: size,
            priority: 3,
          );
          add(earth);
          break;
        case 'pause':
          final pause = Pause(
            position: Vector2(spawnComponent.x, spawnComponent.y),
            size: Vector2(spawnComponent.width, spawnComponent.height),
          );
          add(pause);
          break;

        default:
      }
    }
  }
}
