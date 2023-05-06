import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'dart:math';
import 'package:flame/widgets.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'TrashManager.dart';
import 'Trash.dart';
import 'Poubelle.dart';
import 'TrashManager.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:flame_svg/svg_component.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:flame_svg/svg.dart';
class Recycler extends MiniGame with HasDraggableComponents,HasCollisionDetection{
  late Poubelle premiere,deuxieme,troisieme,quatrieme;
  late TrashManager Manager;
  late List<Svg> AssetsTrash=[];
  late SpriteComponent background=SpriteComponent();
  late SpriteComponent tapis=SpriteComponent();
  late String strBack;
  late Svg svgInstance1,svgInstance2,svgInstance3,svgInstance4;
  int time_of_the_game=60;//in secs
  late double time_interval;
  late double size_poubelleX;
  late double size_poubelleY;
  late double size_tapis_Y;
  late Zones zone;
  bool Started=false;

  Recycler({required super.hud,required this.zone, required super.level, required super.context, required super.challenge}){
    addTimer(seconds: time_of_the_game);
    addPoints(maxPoints: time_of_the_game~/5);
    if(difficulty==Difficulty.EASY){
      addPoints(maxPoints: (time_of_the_game~/5)-1);
    }else{
      if(difficulty==Difficulty.MEDIUM){
        addPoints(maxPoints: (time_of_the_game~/4)-1);
      }else{
        addPoints(maxPoints: (time_of_the_game~/3)-1);
      }
    }
  }
  Future<void> onLoad() async {
    //initialisations
    await super.onLoad();
    Flame.device.fullScreen();
    Flame.device.setLandscape();
    //audio
    //SpriteSheet
    if(zone==Zones.foret){
      strBack="backForet";
      svgInstance1 = await Svg.load("images/Recycler/poubelles/noir.svg");
      svgInstance2= await Svg.load("images/Recycler/poubelles/bleu.svg");
      svgInstance3 = await Svg.load("images/Recycler/poubelles/orange.svg");
      svgInstance4 = await Svg.load("images/Recycler/poubelles/vert.svg");
      for(int i=1;i<=4;i++){
        AssetsTrash.add(await Svg.load("images/Recycler/dechets/ORGANIC/${i}.svg"));
      }
      for(int i=1;i<=4;i++){
        AssetsTrash.add(await Svg.load("images/Recycler/dechets/PAPER/${i}.svg"));
      }
      for(int i=1;i<=4;i++){
        AssetsTrash.add(await Svg.load("images/Recycler/dechets/PLASTIC/${i}.svg"));
      }
      for(int i=1;i<=4;i++){
        AssetsTrash.add(await Svg.load("images/Recycler/dechets/GLASS/${i}.svg"));
      }
    }else {
      if (zone == Zones.zoneIndustrielle) {
        strBack = "backIndu";
        svgInstance1 = await Svg.load(
            "images/Recycler/poubelles/orange.svg");
        svgInstance2 = await Svg.load(
            "images/Recycler/poubelles/vert.svg");
        svgInstance3 = await Svg.load(
            "images/Recycler/poubelles/rouge.svg");
        svgInstance4 = await Svg.load(
            "images/Recycler/poubelles/jaune.svg");
        for (int i = 1; i <= 4; i++) {
          AssetsTrash.add(
              await Svg.load("images/Recycler/dechets/PLASTIC/${i}.svg"));
        }
        for (int i = 1; i <= 4; i++) {
          AssetsTrash.add(
              await Svg.load("images/Recycler/dechets/GLASS/${i}.svg"));
        }
        for (int i = 1; i <= 4; i++) {
          AssetsTrash.add(
              await Svg.load("images/Recycler/dechets/METAL/${i}.svg"));
        }
        for (int i = 1; i <= 4; i++) {
          AssetsTrash.add(
              await Svg.load("images/Recycler/dechets/EWASTE/${i}.svg"));
        }
      } else {
        if (zone == Zones.mer) {
          strBack = "backMer";
          svgInstance1 = await Svg.load(
              "images/Recycler/poubelles/noir.svg");
          svgInstance2 = await Svg.load(
              "images/Recycler/poubelles/orange.svg");
          svgInstance3 = await Svg.load(
              "images/Recycler/poubelles/vert.svg");
          svgInstance4 = await Svg.load(
              "images/Recycler/poubelles/rouge.svg");
          for (int i = 1; i <= 4; i++) {
            AssetsTrash.add(
                await Svg.load("images/Recycler/dechets/ORGANIC/${i}.svg"));
          }
          for (int i = 1; i <= 4; i++) {
            AssetsTrash.add(
                await Svg.load("images/Recycler/dechets/PLASTIC/${i}.svg"));
          }
          for (int i = 1; i <= 4; i++) {
            AssetsTrash.add(
                await Svg.load("images/Recycler/dechets/GLASS/${i}.svg"));
          }
          for (int i = 1; i <= 4; i++) {
            AssetsTrash.add(
                await Svg.load("images/Recycler/dechets/METAL/${i}.svg"));
          }
        } else {
          if(zone==Zones.ville){
            strBack = "backVille";
            svgInstance1 = await Svg.load(
                "images/Recycler/poubelles/noir.svg");

            svgInstance2 = await Svg.load(
                "images/Recycler/poubelles/orange.svg");

            svgInstance3 = await Svg.load(
                "images/Recycler/poubelles/rouge.svg");

            svgInstance4 = await Svg.load(
                "images/Recycler/poubelles/jaune.svg");

            for (int i = 1; i <= 4; i++) {
              AssetsTrash.add(
                  await Svg.load("images/Recycler/dechets/ORGANIC/${i}.svg"));
            }

            for (int i = 1; i <= 4; i++) {
              AssetsTrash.add(
                  await Svg.load("images/Recycler/dechets/PLASTIC/${i}.svg"));
            }

            for (int i = 1; i <= 4; i++) {
              AssetsTrash.add(
                  await Svg.load("images/Recycler/dechets/METAL/${i}.svg"));
            }

            for (int i = 1; i <= 4; i++) {
              AssetsTrash.add(
                  await Svg.load("images/Recycler/dechets/EWASTE/${i}.svg"));
            }
          }

        }
      }
    }
    //background
    size_tapis_Y=size[1]/3;
    add(background
      ..sprite = await loadSprite('Recycler/backgrounds/'+strBack+'.png')
      ..size = Vector2(size[0], size[1]-size_tapis_Y)
      ..position=Vector2(0,0));


    //le tapis
    if(difficulty==Difficulty.EASY){
      time_interval=5;
    }else{
      if(difficulty==Difficulty.MEDIUM){
        time_interval=4;
      }else{
        time_interval=3;
      }
    }
    tapis
      ..sprite=await loadSprite("Recycler/tapis.png")
      ..size=Vector2(size[0], size_tapis_Y)
      ..position=Vector2(0, size[1]-size_tapis_Y);
    add(tapis);
    //les poubelles
    size_poubelleX=size[0]/8;
    size_poubelleY=size_poubelleX*358/249;
    double gap=(size[0]-4*size_poubelleX)/5;
    premiere =
        Poubelle(position: Vector2(gap+size_poubelleX*1/2, size[1] - size_poubelleY/2-size_tapis_Y), num: 1); //size[0]/10 za3ma la moitie ta3 size[0]/10 pour rapprocher
    premiere
      ..svg =  svgInstance1
      ..size = Vector2(size_poubelleX,size_poubelleY);
    deuxieme = Poubelle(
        position: Vector2(gap*2+size_poubelleX*3/2, size[1] - size_poubelleY/2-size_tapis_Y), num: 2);
    deuxieme
      ..svg =  svgInstance2
      ..size = Vector2(size_poubelleX,size_poubelleY);
    troisieme =
        Poubelle(position: Vector2(gap*3+2*size_poubelleX+size_poubelleX*1/2, size[1] - size_poubelleY/2-size_tapis_Y), num: 3);
    troisieme
      ..svg =  svgInstance3
      ..size = Vector2(size_poubelleX,size_poubelleY);
    quatrieme =
        Poubelle(position: Vector2(gap*4+3*size_poubelleX+size_poubelleX*1/2, size[1] - size_poubelleY/2-size_tapis_Y), num: 4);
    quatrieme
      ..svg =svgInstance4
      ..size = Vector2(size_poubelleX,size_poubelleY);
    Manager = TrashManager(
      time_interval: time_interval,
        TabAsset:AssetsTrash,
        gameRef: this,
        premiere: premiere,
        deuxieme: deuxieme,
        troisieme: troisieme,
        quatrieme: quatrieme,
        size2: size,
        position_spawn:Vector2(-3*size[0]/8, size[1]-size_tapis_Y*2/3),
        size_tapisY: size_tapis_Y
    );

    //adding
    add(premiere);
    add(deuxieme);
    add(troisieme);
    add(quatrieme);


  }
  void onBegin(){
    Started=true;
    add(Manager);
    onStart();
  }

  @override
  void showTutorial(String? path) async {
    // TODO: implement showTutorial
    await super.showTutorial(path);
    print("test");
    onBegin();
  }



  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
  @override
  void onTimeOut() {
    // TODO: implement onTimeOut
    Manager.Stop();
    super.onTimeOut();

    //gameOver;
  }
  void reset() {
      Manager.reset();
  }
  @override
  void onRestart() {
    super.onRestart();
    reset();
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    showTutorial("assets/tutorials/recycler.png");
  }


}
