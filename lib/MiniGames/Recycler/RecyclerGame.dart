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
  int time_of_the_game=60;//temps du jeu
  late double time_interval;//LAPSE DE TEMPS ENTRE 2 DECHETS
  late double size_poubelleX;//HAUTEUR DE LA POUBELLE
  late double size_poubelleY;//LARGEUR DE LA POUBELLE
  late double size_tapis_Y;//HAUTEUR DU TAPIS
  bool Started=false;//booleen qui indique le debut dujeu

  Recycler({required super.hud,required super.zone, required super.context, required super.challenge, required super.level}){
    ///REGLAGE DES PARAMETRES DU JEU
    if(difficulty==Difficulty.EASY){
      addPoints(maxPoints:10);
    }else{
      if(difficulty==Difficulty.MEDIUM){
        addPoints(maxPoints:15);
      }else{
        addPoints(maxPoints: 20);
      }
    }
  }
  Future<void> onLoad() async {
    //initialisations
    await super.onLoad();
    Flame.device.fullScreen();
    Flame.device.setLandscape();
    //audio a faire dans le version futures
    //SpriteSheet
    if(zone==Zones.foret){
      ///SI NOUS SOMMES DANS LA ZONE FORET
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
        ///SI NOUS SOMMES DANS LA ZONE INDUSTRIELLE

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
          ///SI NOUS SOMMES DANS LA MER
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
            ///SI NOUS SOMMES DANS LA VILLE

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
    ///LA DIFFICULTE
    if(difficulty==Difficulty.EASY){
      time_interval=4.5;
    }else{
      if(difficulty==Difficulty.MEDIUM){
        time_interval=3.5;
      }else{
        time_interval=2.5;
      }
    }
    ///LE TAPIS
    tapis
      ..sprite=await loadSprite("Recycler/tapis.png")
      ..size=Vector2(size[0], size_tapis_Y)
      ..position=Vector2(0, size[1]-size_tapis_Y);
    add(tapis);
    //les poubelles
    size_poubelleX=size[0]/8;
    size_poubelleY=size_poubelleX*358/249;
    //LE GAP ENTRE
    double gap=(size[0]-4*size_poubelleX)/5;
    //LA PREMIERE POUBELLE
    premiere =
        Poubelle(position: Vector2(gap+size_poubelleX*1/2, size[1] - size_poubelleY/2-size_tapis_Y), num: 1); //size[0]/10 za3ma la moitie ta3 size[0]/10 pour rapprocher
    premiere
      ..svg =  svgInstance1
      ..size = Vector2(size_poubelleX,size_poubelleY);
    //LA DEUXIEME POUBELLE
    deuxieme = Poubelle(
        position: Vector2(gap*2+size_poubelleX*3/2, size[1] - size_poubelleY/2-size_tapis_Y), num: 2);
    deuxieme
      ..svg =  svgInstance2
      ..size = Vector2(size_poubelleX,size_poubelleY);
    //LA TROISIEME POUBELLE

    troisieme =
        Poubelle(position: Vector2(gap*3+2*size_poubelleX+size_poubelleX*1/2, size[1] - size_poubelleY/2-size_tapis_Y), num: 3);
    troisieme
      ..svg =  svgInstance3
      ..size = Vector2(size_poubelleX,size_poubelleY);
    //LA QUATRIEME POUBELLE

    quatrieme =
        Poubelle(position: Vector2(gap*4+3*size_poubelleX+size_poubelleX*1/2, size[1] - size_poubelleY/2-size_tapis_Y), num: 4);
    quatrieme
      ..svg =svgInstance4
      ..size = Vector2(size_poubelleX,size_poubelleY);

    //LE MANAGER
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
    ///L'AJOUT DES POUBELLES
    add(premiere);
    add(deuxieme);
    add(troisieme);
    add(quatrieme);
    //AFFICHAGE DU TUTORIEL
    showTutorial("assets/tutorials/recycler.png");
  }

  @override
  FutureOr<void> showTutorial(String? path) async {
    //FONCTION POUR AFFICHER LE TUTORIEL
    await super.showTutorial(path);
    onBegin();
  }

  void onBegin(){
    //DEBUT DU JEU
    Started=true;
    add(Manager);
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
    //FONCTION POUR RESET LE MANAGER
      Manager.reset();
  }
  @override
  void onRestart() {
    //FONCTION POUR RECOMMENCER LE JEU
    super.onRestart();
    reset();
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();

  }


}
