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
  late SpriteComponent Background = SpriteComponent();//le sprite du background
  TextPaint textPaint = TextPaint(
    style: TextStyle(
      fontSize: 20,
      fontFamily: 'Awesome Font',
    ),
  );
  late Timer _timer;//Le timer du debut du jeu qui indique combien de temps avant de spawn le puzzle
  bool restart=false;//recommencer
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
  late int time=300;
  late double TimeShown;

  @override
  void onRestart() {// fonction pour redemarrer le mini jeu
    super.onRestart();

    this.Correct=0;//initialisation

    if(PuzzleAdded==true){//le puzzle a ete ajoute
      if(NbImages>0){//si ce n'est pas le derniere image
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
    //reinitialisation des constantes et des tables
    NbImages = 5;
    Index = random.nextInt(NbImages);
    spritesheets = [];
    Originales = [];
    IndexImages = [];
    //reremplir la liste
    RemplirListe();
    //reinitialisation des booleens
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


  //Constructeur du jeu PuzzleGame
  PuzzleGame({required super.hud,required super.zone, required super.context,
    required super.level, required super.challenge}){
    setInitStars(initStars: 0);
    hud.useBar=true;
    hud.maxPoints=NbImages;
    //REGLAGE DES PARAMETRES SELON LA DIFFICULTE
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
  void spawnPuzzle(){ //Fonction qui spawn un puzzle
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
    //Fonction du hud
    // TODO: implement setStars
    super.setStars(stars: stars);
  }

  //------------------------
  //LE FORMAT DES IMAGES SERA
  //"{Leve}{Num de l'image}{type}.png"
  //si le num de l'image est modulo 2 ca veut dire c une bonne action
  //type=0 si originale 1 si spritesheet
  //------------------------
  //Initialisations
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
    ///Fonction qui remplit les lists spritesheets et ImageOriginales avec les Index qui seront important
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
      ///Insertion des Information de la boucle
      IndexImages.insert(0, j);
      Originales.insert(0, Originale);
      spritesheets.insert(0, spritesheet);

    }
  }
  @override
  Color backgroundColor() => Colors.transparent;
  ///DEBUT DE LA FONCTION ONLOAD
  @override
  FutureOr<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    Flame.device.fullScreen();
    Flame.device.setLandscape();


    //SpriteSheet


    RemplirListe(); //remplir les listes
    //LE BACKGROUND
    Index = random.nextInt(NbImages);
    //LE MANAGER
    puzzleManager = PuzzleManager(level: LevelDiff,
        spriteSheet: spritesheets[Index],
        sizeScr: size,
        Xdebut: Xdebut,
        Ydebut: Ydebut,
        taille: taille);
    //-----------------------------------------------------
    //LA GRID
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
    if(Started){///SI LE JEU COMMENCE
      if(restart){///SI C'EST POUR RECOMMENCER
        TimerOn=false;
        restart=false;
      }
      if(PuzzleAdded==false && TimerOn==false && firstOne==true){///SI C'EST LA PREMIERE IMAGE
        firstOne=false;
        TimerOn=true;
        add(Grid);
        add(Originales[Index]);
        _timer.start();
      }
      if(TimerOn){
        _timer.update(dt);
      }
      if(PuzzleAdded){///SI LE PUZZLE EST AJOUTE
        if (puzzleManager.PuzzleFinished && overlayPresent == false){
          overlayPresent = true;
          puzzleManager.PuzzleFinished=false;
          this.overlays.add(PuzzleChoice.id);
          puzzleManager.children.whereType<PuzzlePiece>().forEach((i) {
            i.removeFromParent();
          });
          add(Originales[Index]);
        }
        if (Choisit) {///SI LE JOUEUR A CHOISIT
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
    //Ajouter le tuto du jeu
    showTutorial("assets/tutorials/puzzle.png");
  }

  @override
  FutureOr<void> showTutorial(String? path) async {
    // TODO: implement showTutorial
    await super.showTutorial(path);
    //commencer le jeu
    onBegin();
  }

}