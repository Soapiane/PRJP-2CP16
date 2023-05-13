import 'dart:async';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'PuzzlePiece.dart';
import 'dart:math';

import 'PuzzlePiece.dart';
class PuzzleManager extends Component{
  int level;
  SpriteSheet spriteSheet;
  late bool PuzzleFinished=false;
  Vector2 sizeScr;
  late PuzzlePiece Piece;
  late List<PuzzlePiece> Pieces=[];
  late int index;

  double Xdebut;
  double Ydebut;
  double taille;
  PuzzleManager({required this.level,required this.spriteSheet,required this.sizeScr ,required this.Xdebut,required this.Ydebut,required this.taille});
  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    PuzzleFinished=false;
    index=this.level*this.level;
    for(int i=0;i<level*level;i++){
      Piece=PuzzlePiece(Level: level, ind: i, puzzleManager: this, sizeScr: this.sizeScr,Xdebut: this.Xdebut,Ydebut: this.Ydebut,taille: this.taille);
      Pieces.add(Piece);
    }
    SpawnNew();
  }
  void SpawnNew(){
    if(index==0){
      PuzzleFinished=true;
    }else{
      Random random = new Random();
      int randomNumber = random.nextInt(index);
      add(Pieces[randomNumber]
        ..sprite=spriteSheet.getSpriteById(Pieces[randomNumber].ind)
        ..size=Vector2(Pieces[randomNumber].CalculerFakeW_TQ(taille/level), Pieces[randomNumber].CalculerFakeH_TQ(taille/level))
        ..position=Vector2(Pieces[randomNumber].CalculateX((sizeScr[0]+Xdebut+taille)/2-taille/(level*2)),Pieces[randomNumber].CalculateY(sizeScr[1]/2-taille/(level*2)) )
    );
      Pieces.remove(Pieces[randomNumber]);
    }
    index-=1;
  }
}