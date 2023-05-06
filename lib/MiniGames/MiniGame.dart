import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/MiniGames/Hud/MiniGameHUD.dart';
import 'package:projet2cp/MiniGames/TutoScreen.dart';
import 'package:projet2cp/Navigation/DefiState.dart';
import 'package:projet2cp/Navigation/Loading.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MiniGame extends FlameGame {

  final MiniGameHUD hud;
  final Difficulty difficulty = Info.difficulty;
  late Zones zone;
  late int level;
  int? challenge;
  BuildContext? context;

   MiniGame({required this.hud, this.zone = Zones.ville, this.level = 1, this.challenge, this.context}){
     hud.onMaxPointsReached = onMaxPointsReached;
     hud.onGameTimeOut = onTimeOut;
     hud.onGamePaused = onPaused;
     hud.resumeGame = onResume;
     hud.onStarsModified = onStarsModified;
     hud.onPointsModified = onPointsModified;
     hud.restartGame = onRestart;
     hud.onTimeUpdate = onTimeUpdate;
   }
  FutureOr<void> showTutorial(String? path) async {



    if (context != null) {
      await showDialog(
        context: context!,
        builder: (context){
          return TutoScreen(path: path,);
        },
      );
    }
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

     hud.onFinished();

     await saveProgress();

     if (FirebaseAuth.instance.currentUser != null){
       await DatabaseRepository().printDB();
       await DatabaseRepository().syncZone(zone);
     } else {
        await GuestRepository().printDB();
     }

     Loading.HideLoading(hud.getHudContext());

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

  void setPointsString({required String name}) {
     hud.pointsText = name;
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
        await DatabaseRepository().database!.update(
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

        await DatabaseRepository().database!.update(
              "zone",
              {
                "stars": zoneInfo["stars"] + differenceStars,
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
          prefs.setString("newTrophy", (await DatabaseRepository().database!.query(
            "trophy",
            where: "id = ?",
            whereArgs: [zone.id],
          )).toList()[0]["title"] as String);
        }


        ///give the challenge

        if (challenge != null) {
          Map challengeInfo = (await DatabaseRepository().database!.query(
            "challenge",
            where: "id = ?",
            whereArgs: [challenge!],
          ))
              .toList()[0];

          if (challengeInfo["state"] == DefiState.nonCollected.index) {
            DatabaseRepository().database!.update(
                  "challenge",
                  {
                    "state": DefiState.collected.index,
                  },
                  where: "id = ?",
                  whereArgs: [challenge!],
                );
            prefs.setString("newChallenge", challengeInfo["title"] as String);
          }
        }

        }






      } else {

       ///checking if any changes happened
       Map levelInfo = (await GuestRepository().database!.query(
         "level",
         where: "zone_id = ? AND level = ?",
         whereArgs: [zone.id, level],
       ))[0];

       if (levelInfo["stars"] < getStars()){
         differenceStars = (getStars() - levelInfo["stars"]) as int?;
       }
       if (differenceStars != 0) {

         print("LEVEL : $level");
         ///Update the stars
         await GuestRepository().database!.update(
           "level",
           {
             "stars": levelInfo["stars"] + differenceStars!,
           },
           where: "zone_id = ? AND level = ?",
           whereArgs: [zone.id, level],
         );

         ///update the zone info
         Map zoneInfo = (await GuestRepository().database!.query(
           "zone",
           where: "id = ?",
           whereArgs: [zone.id],
         ))[0];

         await GuestRepository().database!.update(
           "zone",
           {
             "stars": zoneInfo["stars"] + differenceStars,
             "levelReached": (level == zoneInfo["levelReached"] && level != zoneInfo["levelsNb"]-1) ? level + 1 : zoneInfo["levelReached"],
           },
           where: "id = ?",
           whereArgs: [zone.id],
         );

         ///Unlock the next level if there's
         if (level != zoneInfo["levelsNb"]-1) {

           GuestRepository().database!.update(
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
         int allStars = (await GuestRepository().database!.rawQuery("SELECT SUM(stars) as Total FROM level GROUP BY zone_id")).toList()[Zones.ville.index]["Total"] as int;
         int trophyAcquired = (await GuestRepository().database!.query(
           "trophy",
           where: "id = ?",
           whereArgs: [zone.id],
         )).toList()[0]["isCollected"] as int;

         if (allStars == zoneInfo["levelsNb"]*3 && trophyAcquired == 0) {
           GuestRepository().database!.update(
             "trophy",
             {
               "isCollected": 1,
             },
             where: "id = ?",
             whereArgs: [zone.id],
           );
           prefs.setString("newTrophyGuest", (await GuestRepository().database!.query(
             "trophy",
             where: "id = ?",
             whereArgs: [zone.id],
           )).toList()[0]["title"] as String);
         }


         ///give the challenge

         if (challenge != null) {
           Map challengeInfo = (await GuestRepository().database!.query(
             "challenge",
             where: "id = ?",
             whereArgs: [challenge!],
           ))
               .toList()[0];

           if (challengeInfo["state"] == DefiState.nonCollected.index) {
             GuestRepository().database!.update(
               "challenge",
               {
                 "state": DefiState.collected.index,
               },
               where: "id = ?",
               whereArgs: [challenge!],
             );
             prefs.setString("newChallengeGuest", challengeInfo["title"] as String);
           }
         }

       }

       
     }
    }
  }



