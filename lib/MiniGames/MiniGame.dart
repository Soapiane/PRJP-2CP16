

import 'package:flame/game.dart';
import 'package:projet2cp/MiniGames/MiniGameHUD.dart';

abstract class MiniGame extends FlameGame {

  final MiniGameHUD hud;

   MiniGame({required this.hud}){
     hud.onGameTimeOut = onTimeOut;
     hud.onGamePaused = onPaused;
   }


   void onTimeOut(){

   }


   void onPaused(){

     pauseEngine();
   }

   void onResume(){

   }

   void onRestart(){

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

   void removeTimer(){

   }

   void addPoints(){

   }

   void removePoints(){

   }

}