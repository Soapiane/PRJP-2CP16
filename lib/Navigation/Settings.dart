
//---------------------------------------------------------------
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/Info/Language.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/MiniGames/Hud/PauseScreen.dart';
import 'package:projet2cp/StandardWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Function onDeconnexion, onBackButtonTapped;
  Settings({Key? key, required this.onDeconnexion, required this.onBackButtonTapped}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late double screenHeight;
  late double screenWidth;

  late Difficulty difficulty;
  late Language language;
  late bool sound;

  late List<Widget> Liste;
  late String strLan,strDif;

  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  void ChangeDifficulty(){
    if (difficulty == Difficulty.EASY) {
      setState(() {
        strDif = 'Moyen';
        difficulty=Difficulty.MEDIUM;
      });
    } else {
      if (difficulty == Difficulty.MEDIUM) {
        setState(() {
          strDif = 'Difficile';
          difficulty=Difficulty.HARD;
        });
      } else {
        setState(() {
          strDif = 'Facile';
          difficulty=Difficulty.EASY;

        });
      }
    }
    Info.setDifficulty(difficulty);
  }
  void onDeconnexion(){
    widget.onDeconnexion.call();
  }
  void onChangeLang(){
    if (language == Language.arabic) {
      setState(() {
        strLan = 'FR';
        language=Language.french;
      });
    } else {
      if (language == Language.french) {
        setState(() {
          strLan = 'EN';
          language=Language.english;
        });
      } else {
        setState(() {
          strLan = 'AR';
          language=Language.arabic;

        });
      }
    }
    Info.setLanguage(language);
  }
  void onSoundChange(){
    if(sound==true){
      sound=false;
      setState(() {
        Liste=[
          SvgPicture.asset("assets/hud/pause_screen/sound_off.svg",height: 19*screenHeight/360,width: 14*screenWidth/800,),

          TextUI(text: "Son:OFF",font: 13.5)
        ];
      });
    }else{
      sound=true;
      setState(() {
        Liste=[
          SvgPicture.asset("assets/hud/pause_screen/sound_on.svg",height: 19*screenHeight/360,width: 14*screenWidth/800,),
          TextUI(text: "Son:ON",font: 16)
        ];
      });
    }
    Info.setSound(sound);
  }
  final pauseIcon=Image.asset("assets/icons/pause.png");
  final RestartIcon=Image.asset("assets/icons/restart.png");
  final soundOnIcon=Image.asset("assets/icons/son_on.png");
  final soundOffIcon=Image.asset("assets/icons/son_off.png");
  @override
  Widget build(BuildContext context) {



    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    difficulty = Info.difficulty;
    language = Info.language;
    sound = Info.sound;

    if (sound == true) {
      setState(() {
        Liste = [
          SvgPicture.asset(
            "assets/hud/pause_screen/sound_on.svg", height: 19 * screenHeight / 360,
            width: 14 * screenWidth / 800,),
          TextUI(text: "Son:ON", font: 16,)
        ];
      });
    } else {
      setState(() {
        Liste = [
          SvgPicture.asset(
            "assets/hud/pause_screen/sound_off.svg", height: 19 * screenHeight / 360,
            width: 14 * screenWidth / 800,),

          TextUI(text: "Son:OFF", font: 16,)
        ];
      });
    }
    if (difficulty == Difficulty.EASY) {
      strDif = 'Facile';
    } else {
      if (difficulty == Difficulty.MEDIUM) {
        strDif = 'Moyen';
      } else {
        strDif = 'Difficile';
      }
    }
    if (language == Language.french) {
      strLan = 'FR';
    } else {
      if (language == Language.arabic) {
        strLan = 'AR';
      } else {
        strLan = 'EN';
      }
    }

    final widthCon=screenWidth*1/2;
    final heightCon=screenHeight*4/5;

    StandardWidgets standardWidgets=StandardWidgets(context: context);

    return Stack(
      children:
      [
        Align(
          alignment: Alignment.center,
          child: Container(
          decoration: BoxDecoration(
            color: Color(HexColor("#8CC63F")),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 2,
                offset: Offset(0,2),
              )
            ],
          ),
          height: heightCon,
          width: widthCon,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: screenHeight*26/360),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset("assets/settings/settings.svg",height: 19*screenHeight/360,width: 19*screenWidth/800,),
                      TextUI(text: "Paramétres", font: 20),
                      SvgPicture.asset("assets/settings/settings.svg",height:19*screenHeight/360,width: 19*screenWidth/800),

                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: screenHeight*5.5/360),
                  child: Center(
                    child: Container(
                      height: 1,
                      width: widthCon*0.88,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding:  EdgeInsets.only(top: screenHeight*20.5/360),
                  child: BoutonText(text: "Difficulté : "+strDif, couleur: HexColor("#EB8914"), heightCon: 0.17*heightCon,font: 16, widthCon: 0.88*widthCon,onPressed: ChangeDifficulty),
                ),
                //RESTART AND SOUND
                Padding(
                  padding:  EdgeInsets.only(top:screenHeight*12.0/360),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BoutonList(Liste: [
                        SvgPicture.asset("assets/settings/language.svg",color: Colors.white,height: 19*screenHeight/360,width: 19*screenWidth/360,),

                        TextUI(text: "Langue: "+strLan,font: 16,)
                      ]
                          , couleur: HexColor("#47BFFE"), heightCon: 0.18*heightCon, widthCon: 0.52*widthCon, onPressed: onChangeLang),
                      BoutonList(Liste: Liste
                          , couleur:  HexColor("#DDE108"), heightCon: 0.18*heightCon, widthCon: 0.3*widthCon, onPressed: onSoundChange)
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:screenHeight*12.0/360),
                  child: BoutonText(text: FirebaseAuth.instance.currentUser != null ? "Deconnexion" : "Quitter", couleur: HexColor("#AA2422"),font: 16, heightCon: 0.17*heightCon, widthCon: 0.88*widthCon,onPressed: onDeconnexion),
                ),

                //CONTINUE BUTTON

              ],
            ),
          ),
      ),
        ),
      ],
    );
  }
}