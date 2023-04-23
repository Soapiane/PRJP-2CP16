import 'dart:async';

import 'package:flame/game.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/MiniGames/MiniGameHUD.dart';
import 'package:projet2cp/Info/User.dart';

abstract class MiniGame extends FlameGame {

  final MiniGameHUD hud;
  final Difficulty difficulty = User().difficulty;

   MiniGame({required this.hud}){
     hud.onMaxPointsReached = onMaxPointsReached;
     hud.onGameTimeOut = onTimeOut;
     hud.onGamePaused = onPaused;
     hud.resumeGame = onResume;
     hud.onStarsModified = onStarsModified;
     hud.onPointsModified = onPointsModified;
     hud.restartGame = onRestart;
     hud.onTimeUpdate = onTimeUpdate;
   }

   void onTimeUpdate(Duration duration){
   }

   void onStarsModified(int stars){
   }

   void onPointsModified(int newPoints, int addedPoints){
   }

   void onMaxPointsReached(){
     pauseEngine();
   }


   void onTimeOut(){
      pauseEngine();
   }



   void onStart(){
    hud.state.onStart();
   }


   void onPaused(){
     pauseEngine();

   }

   void onResume(){

     resumeEngine();

   }

   void onRestart(){
     resumeEngine();
   }

   void onFinished(){
     hud.onFinished();
     pauseEngine();
   }

   void modifyPoints({required int points}){
     hud.modifyPoints(points: points);
   }

   void addTimer({required int seconds}){
     hud.countdown = seconds;
   }

  Duration? getTimer(){
    return hud.getTimer();
  }


  void addPoints({required int maxPoints, int initialPoints = 0}){
    hud.maxPoints = maxPoints;
    hud.initialPoints = initialPoints % (maxPoints+1);
   }


   void removePoints(){

   }


  int getPoints(){
    return hud.getPoints();
  }

  void setPointsAsset({required String asset}){
    hud.pointsAsset = asset;
  }

  void setStars({required int stars}){
    hud.setStars(stars: stars);
  }

  void setInitStars({required int initStars}){
    hud.initialStars = initStars%4;
  }

  int getStars(){
    return hud.getStars();
  }


  void onLose(){
     hud.state.onLose();
    pauseEngine();
  }



}