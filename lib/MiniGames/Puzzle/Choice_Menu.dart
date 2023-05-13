import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'PuzzleGame.dart';
import 'package:projet2cp/Navigation/Zones.dart';
class PuzzleChoice extends StatefulWidget {
  static const String id = 'PuzzleChoice';
  final MiniGame gameRef;
   PuzzleChoice({Key? key,required this.gameRef}) : super(key: key);

  @override
  State<PuzzleChoice> createState() => _PuzzleChoiceState();
}

class _PuzzleChoiceState extends State<PuzzleChoice> {
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }


  @override
  Widget build(BuildContext context) {
    final puzzleGame=widget.gameRef as PuzzleGame;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [

        Positioned(
          top: 65*screenHeight/385,
          left: screenWidth*40/100+screenWidth*1/8+screenWidth/20,
          child: Container(
            height: 163*screenHeight/385,
            width: 0.375*screenWidth,

            decoration: BoxDecoration(
              color: Color(HexColor("#518BFA")),
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2,
                  offset: Offset(0, 2),
                )
              ],
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 10*screenWidth/800,right: 10*screenWidth/800),
                      child: Center(
                        child: Text(
                          puzzleGame.zone==Zones.mer ?"l'image représente un ......... geste ":"L’image représente une énergie ...... ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(HexColor("FCF0F0")),
                            decoration: TextDecoration.none,
                            fontSize: 18*screenWidth/800,
                            fontFamily: "AndikaNewBasic",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 238*screenHeight/385,
          left: screenWidth*40/100+screenWidth*1/8+screenWidth/20,
          child: Container(
            height: 68*screenHeight/385,
            width: 0.375*screenWidth*0.45,

            decoration: BoxDecoration(
              color: Color(HexColor("#71AD38")),
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2,
                  offset: Offset(0, 2),
                )
              ],
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Color(HexColor("#71AD38"))),
                ),
                onPressed: (){
                  puzzleGame.Choisit=true;

                  if(puzzleGame.zone==Zones.zoneIndustrielle){
                    if(puzzleGame.IndexImages[puzzleGame.Index]%2==0){
                      print("false");//mauvais
                    }else{
                      puzzleGame.Correct+=1;
                      puzzleGame.modifyPoints(points: 1);
                      if(puzzleGame.Correct>0 && puzzleGame.Correct<3){
                        puzzleGame.setStars(stars: 1);
                      }else{
                        if(puzzleGame.Correct==3 || puzzleGame.Correct==4){
                          puzzleGame.setStars(stars: 2);

                        }else{
                          puzzleGame.setStars(stars: 3);
                        }
                      }

                      print("s7i7");//increase score

                    }
                  }else{
                    if(puzzleGame.IndexImages[puzzleGame.Index]%2==0){
                      puzzleGame.Correct+=1;
                      puzzleGame.modifyPoints(points: 1);
                      if(puzzleGame.Correct>0 && puzzleGame.Correct<3){
                        puzzleGame.setStars(stars: 1);
                      }else{
                        if(puzzleGame.Correct==3 || puzzleGame.Correct==4){
                          puzzleGame.setStars(stars: 2);

                        }else{
                          puzzleGame.setStars(stars: 3);
                        }
                      }

                      print("s7i7");//increase score
                    }else{
                      print("false");
                    }
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.only(left: 5*screenWidth/800,right: 5*screenWidth/800),
                        child: Center(
                          child: Text(
                            puzzleGame.zone==Zones.mer ? "Bon":"Renouvelable",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(HexColor("FFFFFF")),
                              decoration: TextDecoration.none,
                              fontSize: 14*screenWidth/800,
                              fontFamily: "AndikaNewBasic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 238*screenHeight/385,
          left: screenWidth*40/100+screenWidth*1/8+screenWidth/20+0.375*screenWidth*0.1+0.375*screenWidth*0.45,
          child: Container(
            height: 68*screenHeight/385,
            width: 0.375*screenWidth*0.45,

            decoration: BoxDecoration(
              color: Color(HexColor("#E06E52")),
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2,
                  offset: Offset(0, 2),
                )
              ],
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Color(HexColor("#E06E52"))),
                ),
                onPressed: (){
                  puzzleGame.Choisit=true;

                  if(puzzleGame.zone==Zones.zoneIndustrielle){
                    if(puzzleGame.IndexImages[puzzleGame.Index]%2==0){
                      puzzleGame.Correct+=1;
                      if(puzzleGame.Correct>0 && puzzleGame.Correct<3){
                        puzzleGame.setStars(stars: 1);
                      }else{
                        if(puzzleGame.Correct==3 || puzzleGame.Correct==4){
                          puzzleGame.setStars(stars: 2);

                        }else{
                          puzzleGame.setStars(stars: 3);
                        }
                      }
                      puzzleGame.modifyPoints(points: 1);

                      print("s7i7");//increase
                    }else{
                      print("false");
                    }
                  }else{
                    if(puzzleGame.IndexImages[puzzleGame.Index]%2==0){
                      print("false");
                    }else{
                      puzzleGame.Correct+=1;
                      puzzleGame.modifyPoints(points: 1);

                      if(puzzleGame.Correct>0 && puzzleGame.Correct<3){
                        puzzleGame.setStars(stars: 1);
                      }else{
                        if(puzzleGame.Correct==3 || puzzleGame.Correct==4){
                          puzzleGame.setStars(stars: 2);

                        }else{
                          puzzleGame.setStars(stars: 3);
                        }
                      }
                      print("s7i7");//increase
                    }
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child :Padding(
                        padding:  EdgeInsets.only(left: 5*screenWidth/800,right: 5*screenWidth/800),
                        child: Center(
                          child: Text(
                            puzzleGame.zone==Zones.mer ?"Mauvais":"Non Renouvelable",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(HexColor("FFFFFF")),
                              decoration: TextDecoration.none,
                              fontSize: 14*screenWidth/800,
                              fontFamily: "AndikaNewBasic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

