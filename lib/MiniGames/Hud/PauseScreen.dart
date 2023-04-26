import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/Info/User.dart' as user;
import 'package:projet2cp/Info/Guest.dart' as guest;



class PauseScreen extends StatefulWidget {
  bool sound;
  double screenHeight;
  double screenWidth;
  Function() onResume, onRestart, onQuit;
  PauseScreen({Key? key,required this.sound,required this.screenHeight,required this.screenWidth,
  required this.onResume, required this.onRestart, required this.onQuit}) : super(key: key);

  @override
  State<PauseScreen> createState() => _PauseScreenState();
}

class _PauseScreenState extends State<PauseScreen> {
  late List<Widget> Liste;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.sound==true){
      setState(() {
        Liste=[
          SvgPicture.asset("assets/hud/pause_screen/sound_on.svg",height: 19*widget.screenHeight/360,width: 14*widget.screenWidth/800,),
          TextUI(text: "Son:ON",font: 16,)
        ];
      });
    }else{
      setState(() {
        Liste=[
          SvgPicture.asset("assets/hud/pause_screen/sound_off.svg",height: 19*widget.screenHeight/360,width: 14*widget.screenWidth/800,),

          TextUI(text: "Son:OFF",font: 13.5,)
        ];
      });
    }
  }
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  void onSoundChange(){
    if(widget.sound==true){
      widget.sound=false;
      setState(() {
        Liste=[
          SvgPicture.asset("assets/hud/pause_screen/sound_off.svg",height: 19*widget.screenHeight/360,width: 14*widget.screenWidth/800,),

          TextUI(text: "Son:OFF",font: 13.5)
        ];
      });
    }else{
      widget.sound=true;
      setState(() {
        Liste=[
          SvgPicture.asset("assets/hud/pause_screen/sound_on.svg",height: 19*widget.screenHeight/360,width: 14*widget.screenWidth/800,),
          TextUI(text: "Son:ON",font: 16)
        ];
      });
    }

    FirebaseAuth.instance.currentUser != null ? user.User().setSound(widget.sound) : user.User().setSound(widget.sound);

  }
  final pauseIcon=Image.asset("assets/icons/pause.png");
  final RestartIcon=Image.asset("assets/icons/restart.png");
  final soundOnIcon=Image.asset("assets/icons/son_on.png");
  final soundOffIcon=Image.asset("assets/icons/son_off.png");
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final widthCon=screenWidth*1/2;
    final heightCon=screenHeight*4/5;

    return Center(
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
                padding:  EdgeInsets.only(top: screenHeight*26/360, left: screenWidth*30/800, right: screenWidth*30/800),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/hud/pause_screen/pause.svg",height: 19*screenHeight/360,width: 19*screenWidth/800,),
                    TextUI(text: "Pause", font: 20),
                    SvgPicture.asset("assets/hud/pause_screen/pause.svg",height:19*screenHeight/360,width: 19*screenWidth/800),

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
                          color: Color(HexColor("#ffffff")),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding:  EdgeInsets.only(top: screenHeight*20.5/360),
                child: BoutonText(text: "Continuer", couleur: HexColor("#EB8914"), heightCon: 0.17*heightCon,font: 16, widthCon: 0.88*widthCon,onPressed: widget.onResume),
              ),
              //RESTART AND SOUND
              Padding(
                padding:  EdgeInsets.only(top:screenHeight*12.0/360),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BoutonList(Liste: [
                      SvgPicture.asset("assets/hud/pause_screen/restart.svg",color: Colors.white,height: 19*screenHeight/360,width: 19*screenWidth/800,),

                      TextUI(text: "Recommencer",font: 16,)
                    ]
                        , couleur: HexColor("#47BFFE"), heightCon: 0.18*heightCon, widthCon: 0.52*widthCon, onPressed: widget.onRestart),
                    BoutonList(Liste: Liste
                        , couleur:  HexColor("#DDE108"), heightCon: 0.18*heightCon, widthCon: 0.3*widthCon, onPressed: onSoundChange)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top:screenHeight*12.0/360),
                child: BoutonText(text: "Quitter", couleur: HexColor("#AA2422"),font: 16, heightCon: 0.17*heightCon, widthCon: 0.88*widthCon,onPressed: widget.onQuit),
              ),

              //CONTINUE BUTTON

            ],
          ),
        ),
      ),
    );
  }
}

class BoutonText extends StatelessWidget {
  String text;
  int couleur;
  double heightCon,widthCon;
  VoidCallback onPressed;
  double font;
  BoutonText({Key? key,required this.text,required this.couleur,required this.heightCon,required this.widthCon,required this.font,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Container(
        height:heightCon ,
        width:  widthCon,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 2,
              offset: Offset(0,2),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ElevatedButton(
            style:ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Color(couleur)),
            ),
            onPressed: onPressed,
            child: Center(
              child: TextUI(text: this.text,font: font,)
            ),
          ),
        ),
      ),
    );
  }
}
class BoutonList extends StatelessWidget {
  int couleur;
  double heightCon,widthCon;
  VoidCallback onPressed;
  List<Widget> Liste;

  BoutonList({Key? key,required this.Liste,required this.couleur,required this.heightCon,required this.widthCon,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height:heightCon ,
        width:  widthCon,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 2,
              offset: Offset(0,2),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ElevatedButton(
            style:ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Color(couleur)),
            ),
            onPressed: onPressed,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: Liste,
              )
            ),
          ),
        ),
      ),
    );
  }
}
class TextUI extends StatelessWidget {
  String text;
  double font;
  TextUI({Key? key,required this.text,required this.font}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Text(
      this.text,

      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: font*screenWidth/800,
        fontFamily: "AndikaNewBasic",
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textAlign:TextAlign.center,
    );
  }
}
//-------------------------------------------------------------



//---------------------------------------------------------------
class Parametres extends StatefulWidget {
  bool sound;
  double screenHeight;
  double screenWidth;
  Difficulty difficulty;
  Language language;
  Parametres({Key? key,required this.sound,required this.screenHeight,required this.screenWidth,required this.difficulty,required this.language}) : super(key: key);

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  late List<Widget> Liste;
  late String strLan,strDif;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.sound == true) {
      setState(() {
        Liste = [
          SvgPicture.asset(
            "assets/hud/pause_screen/sound_on.svg", height: 19 * widget.screenHeight / 360,
            width: 14 * widget.screenWidth / 800,),
          TextUI(text: "Son:ON", font: 16,)
        ];
      });
    } else {
      setState(() {
        Liste = [
          SvgPicture.asset(
            "assets/hud/pause_screen/sound_off.svg", height: 19 * widget.screenHeight / 360,
            width: 14 * widget.screenWidth / 800,),

          TextUI(text: "Son:OFF", font: 13.5,)
        ];
      });
    }
    if (widget.difficulty == Difficulty.EASY) {
      strDif = 'Facile';
    } else {
      if (widget.difficulty == Difficulty.MEDIUM) {
        strDif = 'Moyen';
      } else {
        strDif = 'Difficile';
      }
    }
    if (widget.language == Language.FRENCH) {
      strLan = 'FR';
    } else {
      if (widget.language == Language.ARABIC) {
        strLan = 'AR';
      } else {
        strLan = 'EN';
      }
    }
  }
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  void ChangeDifficulty(){
    if (widget.difficulty == Difficulty.EASY) {
      setState(() {
        strDif = 'Moyen';
        widget.difficulty=Difficulty.MEDIUM;
      });
    } else {
      if (widget.difficulty == Difficulty.MEDIUM) {
        setState(() {
          strDif = 'Difficile';
          widget.difficulty=Difficulty.HARD;
        });
      } else {
        setState(() {
          strDif = 'Facile';
          widget.difficulty=Difficulty.EASY;

        });
      }
    }
  }
  void onDeconnexion(){
    print("Deconnexion");
  }
  void onChangeLang(){
    if (widget.language == Language.ARABIC) {
      setState(() {
        strLan = 'FR';
        widget.language=Language.FRENCH;
      });
    } else {
      if (widget.language == Language.FRENCH) {
        setState(() {
          strLan = 'EN';
          widget.language=Language.ENGLISH;
        });
      } else {
        setState(() {
          strLan = 'AR';
          widget.language=Language.ARABIC;

        });
      }
    }
  }
  void onSoundChange(){
    if(widget.sound==true){
      widget.sound=false;
      setState(() {
        Liste=[
          SvgPicture.asset("assets/hud/pause_screen/sound_off.svg",height: 19*widget.screenHeight/360,width: 14*widget.screenWidth/800,),

          TextUI(text: "Son:OFF",font: 13.5)
        ];
      });
    }else{
      widget.sound=true;
      setState(() {
        Liste=[
          SvgPicture.asset("assets/hud/pause_screen/sound_on.svg",height: 19*widget.screenHeight/360,width: 14*widget.screenWidth/800,),
          TextUI(text: "Son:ON",font: 16)
        ];
      });
    }
  }
  final pauseIcon=Image.asset("assets/icons/pause.png");
  final RestartIcon=Image.asset("assets/icons/restart.png");
  final soundOnIcon=Image.asset("assets/icons/son_on.png");
  final soundOffIcon=Image.asset("assets/icons/son_off.png");
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final widthCon=screenWidth*1/2;
    final heightCon=screenHeight*4/5;

    return Center(
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
                    SvgPicture.asset("assets/icons/settings.svg",height: 19*screenHeight/360,width: 19*screenWidth/800,),
                    TextUI(text: "Paramétres", font: 20),
                    SvgPicture.asset("assets/icons/settings.svg",height:19*screenHeight/360,width: 19*screenWidth/800),

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
                          color: Color(HexColor("#19806D")),
                          width: 1,
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
                      SvgPicture.asset("assets/icons/langue.svg",color: Colors.white,height: 19*screenHeight/360,width: 19*screenWidth/360,),

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
                child: BoutonText(text: "Déconnexion", couleur: HexColor("#AA2422"),font: 16, heightCon: 0.17*heightCon, widthCon: 0.88*widthCon,onPressed: onDeconnexion),
              ),

              //CONTINUE BUTTON

            ],
          ),
        ),
      ),
    );
  }
}
enum Difficulty {
  EASY,
  MEDIUM,
  HARD;
}
enum Language{
  FRENCH,
  ARABIC,
  ENGLISH,
}