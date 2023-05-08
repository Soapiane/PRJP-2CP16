import 'dart:io';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/src/game/flame_game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/Attention.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/PaperCan.dart';

import 'package:projet2cp/MiniGames/RunnerVille/actions/PlasticCan.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/car.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/fixedCar.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/fixedHouse.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/lamp.dart';

import 'package:projet2cp/MiniGames/RunnerVille/actions/leaf.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/organicCan.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/organicTrash.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/paperTrash.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/plasticTrash.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/coin.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/earth.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/pause.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/player.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/position.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/trash.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/wall.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/platform.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/fixedLamp.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actions/house.dart';
import 'package:projet2cp/MiniGames/RunnerVille/game.dart';

class Level extends Component with HasGameRef<ArrangerVille> {
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
      ..size = Vector2(120, 120)
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
      final position =
          Vector2(spawnComponent.x, spawnComponent.y - spawnComponent.height);
      final size = Vector2(spawnComponent.width, spawnComponent.height);
      final angle = spawnComponent.rotation;
      switch (spawnComponent.type) {
        //Attention
        case "Attention":
          final attention =
              Attention(gameRef.attention, position: position, size: size);
          add(attention);
          break;
        //Trash

        case 'Bottle':
          final bottle = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 0, y: 1);
          add(bottle);
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
        case 'Pizza':
          final pizza = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 3, y: 0);
          add(pizza);
          break;
        case 'Can':
          final can = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 0, y: 2);
          add(can);
          break;
        case 'Bag':
          final bag = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 2, y: 1);
          add(bag);
          break;
        case 'TunaCan':
          final tunaCan = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 2, y: 2);
          add(tunaCan);
          break;
        case 'SodaCan':
          final sodaCan = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 1, y: 2);
          add(sodaCan);
          break;
        case 'Container':
          final container = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 4, y: 1);
          add(container);
          break;
        case 'Chicken':
          final chicken = Trash(gameRef.spriteTrash,
              position: position, size: size, x: 4, y: 0);
          add(chicken);
          break;

        //Actions

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

        case 'Car':
          final car =
              Car(gameRef.car, position: position, size: size, priority: 1);
          add(car);
          break;

        case 'Lamp':
          final lamp =
              Lamp(gameRef.lamp, position: position, size: size, priority: 1);
          add(lamp);
          break;
        case 'House':
          final house =
              House(gameRef.house, position: position, size: size, priority: 1);
          add(house);
          break;
        case 'PaperTrash':
          final paperTrash = PaperTrash(gameRef.paperTrash,
              position: position, size: size, priority: 1);
          add(paperTrash);
          break;

        //Fixed Actions
        case 'PlasticCan':
          final plasticCan = PlasticCan(gameRef.plasticCan,
              position: position, size: size, priority: 2);
          add(plasticCan);
          break;
        case 'PaperCan':
          final paperCan = PaperCan(gameRef.paperCan,
              position: position, size: size, priority: 2);
          add(paperCan);
          break;
        case 'FixedHouse':
          final fixedHouse = FixedHouse(gameRef.fixedHouse,
              position: position, size: size, priority: 2);
          add(fixedHouse);
          break;
        case 'FixedCar':
          final fixedCar = FixedCar(gameRef.fixedCar,
              position: position, size: size, priority: 2);
          add(fixedCar);
          break;
        case 'FixedLamp':
          final fixedCar = FixedLamp(gameRef.fixedLamp,
              position: position, size: size, priority: 2);
          add(fixedCar);
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
