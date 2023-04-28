import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/MiniGames/Hud/MiniGameHUD.dart';
import 'package:projet2cp/Info/User.dart';
import 'package:projet2cp/Navigation/DefiState.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MiniGame extends FlameGame {

  final MiniGameHUD hud;
  final Difficulty difficulty = Info.difficulty;
  late Zones zone;
  late int level;
  int? challenge;

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

   void onFinished() async{

     await saveProgress();
     await DatabaseRepository().printDB();
     await DatabaseRepository().syncZone(zone);

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

  Future<void> saveProgress() async {

    int? differenceStars = 0;
     if (FirebaseAuth.instance.currentUser != null){
       ///checking if any changes happened
       Map levelInfo = (await DatabaseRepository().database!.query(
         "level",
         where: "zone_id = ? AND level = ?",
         whereArgs: [zone.id, level],
       ))[0];

       if (levelInfo["stars"] < getStars()){
         differenceStars = (getStars() - levelInfo["stars"]) as int?;
       }
       if (differenceStars != 0) {

         ///Update the stars
        DatabaseRepository().database!.update(
              "level",
              {
                "stars": levelInfo["stars"] + differenceStars!,
              },
              where: "zone_id = ? AND level = ?",
              whereArgs: [zone.id, level],
            );

        ///update the zone info
        Map zoneInfo = (await DatabaseRepository().database!.query(
          "zone",
          where: "id = ?",
          whereArgs: [zone.id],
        ))[0];

        DatabaseRepository().database!.update(
              "zone",
              {
                "stars": zoneInfo["stars"] + differenceStars!,
                "levelReached": (level == zoneInfo["levelReached"] && level != zoneInfo["levelsNb"]-1) ? level + 1 : zoneInfo["levelReached"],
              },
              where: "id = ?",
              whereArgs: [zone.id],
            );

        ///Unlock the next level if there's
        if (level != zoneInfo["levelsNb"]-1) {

          DatabaseRepository().database!.update(
            "level",
            {
              "isLocked": 0,
            },
            where: "zone_id = ? AND level = ?",
            whereArgs: [zone.id, level + 1],
          );

        }

        ///give the zone finishing trophy
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int allStars = (await DatabaseRepository().database!.rawQuery("SELECT SUM(stars) as Total FROM level GROUP BY zone_id")).toList()[Zones.ville.index]["Total"] as int;
        int trophyAcquired = (await DatabaseRepository().database!.query(
          "trophy",
          where: "id = ?",
          whereArgs: [zone.id],
        )).toList()[0]["isCollected"] as int;

        if (allStars == zoneInfo["levelsNb"]*3 && trophyAcquired == 0) {
          DatabaseRepository().database!.update(
            "trophy",
            {
              "isCollected": 1,
            },
            where: "id = ?",
            whereArgs: [zone.id],
          );
          prefs.setInt("newTrophy", zone.id);
        }


        ///give the challenge

        if (challenge != null) {
          Map challengeInfo = (await DatabaseRepository().database!.query(
            "challenge",
            where: "id = ?",
            whereArgs: [challenge!],
          ))
              .toList()[0];

          if (challengeInfo["state"] == DefiState.nonCollected) {
            DatabaseRepository().database!.update(
                  "challenge",
                  {
                    "state": DefiState.collected.index,
                  },
                  where: "id = ?",
                  whereArgs: [challenge!],
                );
            prefs.setInt("newChallenge", challenge!);
          }
        }

        }






      }
    }
  }



