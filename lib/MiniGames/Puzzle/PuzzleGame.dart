import 'dart:async';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'Choice_Menu.dart';
import 'dart:math';
import 'PuzzleManager.dart';
import 'PuzzlePiece.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/Navigation/Zones.dart';
class PuzzleGame extends MiniGame with HasTappables,HasDraggableComponents {
  late SpriteComponent Background = SpriteComponent();
  TextPaint textPaint = TextPaint(
    style: TextStyle(
      fontSize: 20,
      fontFamily: 'Awesome Font',
    ),
  );
  late Timer _timer;
  bool restart=false;
  bool TimerOn=false;
  bool firstOne=true;
  bool PuzzleAdded=false;
  bool Started=false;
  bool Buff=false;
  int Correct = 0;
  int NbImages = 5;
  List<SpriteSheet> spritesheets = [];
  List<SpriteComponent> Originales = [];
  List<int> IndexImages=[] ;
  late double Xdebut = size[0] / 8;
  late double Ydebut = size[1]/2-taille/2;
  late double taille = size[0]*40/100;
  late double Xfin = Xdebut + taille; //results
  late double Yfin = Ydebut + taille; //results
  late SpriteSheet spritesheet;
  late SpriteComponent Originale = SpriteComponent();
  late Zones zone;
  late int time=300;
  late double TimeShown;

  @override
  void onRestart() {
    // TODO: implement onRestart
    super.onRestart();

    this.Correct=0;

    if(PuzzleAdded==true){
      if(NbImages>0){
        remove(Grid);
        if(overlayPresent){
          remove(Originales[Index]);
          this.overlays.remove(PuzzleChoice.id);

        }else{
          puzzleManager.children.whereType<PuzzlePiece>().forEach((i) {
            i.removeFromParent();
          });
        }
        remove(puzzleManager);
      }
    }else{
      remove(Grid);
      remove(Originales[Index]);
      _timer.stop();

    }
    NbImages = 5;
    Index = random.nextInt(NbImages);
    spritesheets = [];
    Originales = [];
    IndexImages = [];

    RemplirListe();

    Choisit = false;
    adding = true;
    endLoad = false;
    overlayPresent = false;
    TimerOn = false;
    firstOne = true;
    PuzzleAdded=false;

    restart=true;


  }
  late int LevelDiff;
  PuzzleGame({required super.hud,required this.zone, required super.context,
    required super.level, required super.challenge}){
    setInitStars(initStars: 0);
    hud.useBar=true;
    hud.maxPoints=NbImages;
    if(this.difficulty==Difficulty.EASY){
      LevelDiff=2;
      TimeShown=3;
    }else{
      if(this.difficulty==Difficulty.MEDIUM){
        LevelDiff=3;
        TimeShown=2;
      }else{
        LevelDiff=4;
        TimeShown=1;
      }
    }

  }
  void spawnPuzzle(){
    remove(Originales[Index]);
    puzzleManager = new PuzzleManager(level: LevelDiff,
        spriteSheet: spritesheets[Index],
        sizeScr: size,
        Xdebut: Xdebut,
        Ydebut: Ydebut,
        taille: taille);
    add(puzzleManager..PuzzleFinished=false);
    PuzzleAdded=true;
    TimerOn=false;
  }
  @override
  void setStars({required int stars}) {
    // TODO: implement setStars
    super.setStars(stars: stars);
  }

  //------------------------
  //LE FORMAT DES IMAGES SERA
  //"{Leve}{Num de l'image}{type}.png"
  //si le num de l'image est modulo 2 ca veut dire c une bonne action
  //type=0 si originale 1 si spritesheet
  //------------------------
  bool Choisit = false;
  bool adding = true;
  bool endLoad = false;
  bool overlayPresent = false;

  Random random = new Random();
  late int  Index = random.nextInt(NbImages);

  late PuzzleManager puzzleManager;
  late SpriteComponent Grid = SpriteComponent();
  late Paint paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth=2
    ..darken;
  late Rect rect = Rect.fromLTRB(Xdebut, Ydebut, Xfin, Yfin);

  //Remplir les Listes de spritesheet et images

  void RemplirListe(){
    for (int j = 1; j <= NbImages; j++) {
      Originale = new SpriteComponent();

      if(zone==Zones.zoneIndustrielle) {
        Originale
          ..sprite = Sprite(
              images.fromCache("Puzzle/images/zone_industrielle/images/"+j.toString()+".png"))
          ..position = Vector2(Xdebut, Ydebut)
          ..size = Vector2(taille, taille);

        //SPRITESHEETS
        spritesheet = SpriteSheet.fromColumnsAndRows(
            image: images.fromCache(
                "Puzzle/images/zone_industrielle/"+LevelDiff.toString()+"x"+LevelDiff.toString()+"/"+j.toString()+ ".png"),
            columns: LevelDiff,
            rows: LevelDiff);
        //IMAGES
      }else{
        if(zone==Zones.mer){
          Originale
            ..sprite = Sprite(
                images.fromCache("Puzzle/images/Mer/images/"+j.toString()+".png"))
            ..position = Vector2(Xdebut, Ydebut)
            ..size = Vector2(taille, taille);

          //SPRITESHEETS
          spritesheet = SpriteSheet.fromColumnsAndRows(
              image: images.fromCache(
                  "Puzzle/images/Mer/"+LevelDiff.toString()+"x"+LevelDiff.toString()+"/"+j.toString()+ ".png"),
              columns: LevelDiff,
              rows: LevelDiff);
          //IMAGES
        }
      }
      IndexImages.insert(0, j);
      Originales.insert(0, Originale);
      spritesheets.insert(0, spritesheet);

    }
  }
  @override
  Color backgroundColor() => Colors.transparent;
  @override
  FutureOr<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    Flame.device.fullScreen();
    Flame.device.setLandscape();


    //SpriteSheet


    RemplirListe();
    //LE BACKGROUND
    Index = random.nextInt(NbImages);

    puzzleManager = PuzzleManager(level: LevelDiff,
        spriteSheet: spritesheets[Index],
        sizeScr: size,
        Xdebut: Xdebut,
        Ydebut: Ydebut,
        taille: taille);

    //-----------------------------------------------------
    Grid
      ..sprite = Sprite(images.fromCache("Puzzle/images/Grid"+LevelDiff.toString()+".png"))
      ..size = Vector2(taille, taille)
      ..position = Vector2(Xdebut, Ydebut);
    _timer=Timer(TimeShown, onTick: spawnPuzzle, repeat: true);

  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    if(NbImages>0 && !puzzleManager.PuzzleFinished){
      canvas.drawRect(rect, paint);
    }
  }
  void onBegin(){
    Started=true;
  }
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if(Started){
      if(restart){
        TimerOn=false;
        restart=false;
      }
      if(PuzzleAdded==false && TimerOn==false && firstOne==true){
        firstOne=false;
        TimerOn=true;
        add(Grid);
        add(Originales[Index]);
        _timer.start();
      }
      if(TimerOn){
        _timer.update(dt);
      }
      if(PuzzleAdded){
        if (puzzleManager.PuzzleFinished && overlayPresent == false){
          overlayPresent = true;
          puzzleManager.PuzzleFinished=false;
          this.overlays.add(PuzzleChoice.id);
          puzzleManager.children.whereType<PuzzlePiece>().forEach((i) {
            i.removeFromParent();
          });
          add(Originales[Index]);
        }
        if (Choisit) {
          Choisit = false;
          this.overlays.remove(PuzzleChoice.id);
          overlayPresent=false;
          remove(Originales[Index]);
          Originales.remove(Originales[Index]);
          spritesheets.remove(spritesheets[Index]);
          IndexImages.remove(IndexImages[Index]);
          NbImages-=1;
          if (NbImages == 0) {
            remove(Grid);
            remove(puzzleManager);
            onFinished();
            //FIN
          }else{
            if (NbImages > 0) {
              Index = random.nextInt(NbImages);
              remove(puzzleManager);
              PuzzleAdded=false;
              TimerOn=true;
              add(Originales[Index]);
              _timer.start();
            }
          }
        }
      }
    }
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    showTutorial("assets/tutorials/puzzle.png");
  }

  @override
  FutureOr<void> showTutorial(String? path) async {
    // TODO: implement showTutorial
    await super.showTutorial(path);
    onBegin();
  }

}