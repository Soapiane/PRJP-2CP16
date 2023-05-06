
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class Livre extends StatefulWidget {
  const Livre({Key? key}) : super(key: key);

  @override
  State<Livre> createState() => _LivreState();
}

class _LivreState extends State<Livre> {




  final audioPlayer=AudioPlayer();
  Future playAudio() async{
    if(audioisPlaying){
      await audioPlayer.stop();
      await audioPlayer.setSource(AssetSource("audio/livre_audio_${index}.m4a"));
      await audioPlayer.resume();
    }else{
      if(audioisPlaying==false && index!=1 && index!=2 && index!=3 && index!=15 && index!=24 && index!=31){
        setState(() {
          audioisPlaying=true;
        });
         await audioPlayer.play(AssetSource("audio/livre_audio_${index}.m4a"),);

      }
    }
  }
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  late int index;
  late bool audioisPlaying;
  late bool VilleButton;
  late bool InduButton;
  late bool ForetButton;
  late bool merButton;
  late bool DefisButton;


  bool _hasSound() {

    return !(index<4 || index == 15 || index == 24 || index == 31) ;

  }


  @override
  void initState() {
    super.initState();
    index=1;
    onChangeIndex();
    audioisPlaying=false;
  }
  void onChangeIndex(){
    setState(() {
      VilleButton=false;
      InduButton=false;
      ForetButton=false;
      merButton=false;
      DefisButton=false;
      if(36<=index){
        DefisButton=true;
      }else{
        if(31<=index){
          merButton=true;
        }else{
          if(24<=index){
            ForetButton=true;
          }else{
            if(index>=15){
              InduButton=true;
            }else{
              if(index>=3){
                VilleButton=true;
              }
            }
          }
        }
      }
    });
  }
  void onVille(){
    setState(() {
      index=3;
      onChangeIndex();
    });
  }
  void onIndu(){
    setState(() {
      index=15;
      onChangeIndex();

    });
  }
  void onForet(){
    setState(() {
      index=24;
      onChangeIndex();

    });
  }
  void onMer(){
    setState(() {
      index=31;
      onChangeIndex();

    });
  }
  void onDefis(){
    setState(() {
      index=36;
      onChangeIndex();

    });
  }

  @override
  Widget build(BuildContext context) {


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Color(HexColor("#D2FDA8")),
      child: Center(
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/livre/book_svg/page${index}.svg",
              height: screenHeight,
              width: screenWidth,
            ),
            ///arrow left
            Positioned(
              top: 322*screenHeight/360,
              left: 75*screenWidth/800,
              child: GestureDetector(
                onTap: () async{
                  await audioPlayer.stop();
                  setState(()  {
                    if(index>1){
                      index-=1;
                      onChangeIndex();
                      audioisPlaying=false;

                    }
                  });
                },
                child: SvgPicture.asset(
                  "assets/livre/icons/arrow_left.svg",
                  height: 22*screenHeight/360,
                  width: 14*screenWidth/800,
                ),
              ),
            ),
            ///arrow right

            Positioned(
              top: 322*screenHeight/360,
              left: 647*screenWidth/800,
              child: GestureDetector(
                onTap: () async{
                  await audioPlayer.stop();

                  setState(()  {
                    if(index<59){
                      index+=1;
                      onChangeIndex();
                      audioisPlaying=false;
                    }
                  });
                },
                child: SvgPicture.asset(
                  "assets/livre/icons/arrow_right.svg",
                  height: 22*screenHeight/360,
                  width: 14*screenWidth/800,
                ),
              ),
            ),

            ///Bouton Ville
            !VilleButton ? Positioned(
              top: 6*screenHeight/360,
              left: 711*screenWidth/800,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                      offset: Offset(0, -2),

                    )
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () async{
                      await audioPlayer.stop();
                      setState(() {
                        audioisPlaying=false;
                      });
                      onVille();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/Ville.svg",
                      height: 65*screenHeight/360,
                      width: 65*screenWidth/800,
                    ),
                  ),
                ),
              ),
              ///BOUTON Ville APPUYE
            ) :Positioned(
              top: 19.23*screenHeight/360,
              left: 724*screenWidth/800,
              child: Container(
                child: Center(
                  child: GestureDetector(
                    onTap:  () async{
                      await audioPlayer.stop();
                      setState(() {
                        audioisPlaying=false;
                      });
                      onVille();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/Ville_appuye.svg",
                      height: 39*screenHeight/360,
                      width: 39*screenWidth/800,
                    ),
                  ),
                ),
              ),
            ),

            ///BOUTON Indu
            !InduButton ? Positioned(
              top: 76.75*screenHeight/360,
              left: 711*screenWidth/800,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                      offset: Offset(0, -2),

                    )
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap:  () async{
                      await audioPlayer.stop();
                      setState(() {
                        audioisPlaying=false;
                      });
                      onIndu();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/Industrielle.svg",
                      height: 65*screenHeight/360,
                      width: 65*screenWidth/800,
                    ),
                  ),
                ),
              ),
              ///BOUTON Indu APPUYE
            ) :Positioned(
              top: 90.75*screenHeight/360,
              left: 722*screenWidth/800,
              child: Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () async{
                      await audioPlayer.stop();
                      setState(() {
                        audioisPlaying=false;
                      });
                      onIndu();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/Industrielle_appuye.svg",
                      height: 37*screenHeight/360,
                      width: 43*screenWidth/800,
                    ),
                  ),
                ),
              ),
            ),



             ///BOUTON FORET
             !ForetButton ? Positioned(
              top: 147.5*screenHeight/360,
              left: 711*screenWidth/800,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                      offset: Offset(0, -2),

                    )
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () async{
                      await audioPlayer.stop();
                      setState(() {
                        audioisPlaying=false;
                      });
                      onForet();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/Foret.svg",
                      height: 65*screenHeight/360,
                      width: 65*screenWidth/800,
                    ),
                  ),
                ),
              ),
               ///BOUTON FORET APPUYE
             ) :Positioned(
               top: 158.3*screenHeight/360,
               left: 727.75*screenWidth/800,
               child: Container(
                 child: Center(
                   child: GestureDetector(
                     onTap: () async{
                       await audioPlayer.stop();
                       setState(() {
                         audioisPlaying=false;
                       });
                       onForet();
                     },
                     child: SvgPicture.asset(
                       "assets/livre/icons/Foret_appuye.svg",
                       height: 43.53*screenHeight/360,
                       width: 31.59*screenWidth/800,
                     ),
                   ),
                 ),
               ),
             ),


            ///Bouton Mer

            !merButton ? Positioned(
              top: 218.25*screenHeight/360,
              left: 711*screenWidth/800,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                      offset: Offset(0, -2),

                    )
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () async{
                      await audioPlayer.stop();
                      setState(() {
                        audioisPlaying=false;
                      });
                      onMer();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/mer.svg",
                      height: 65*screenHeight/360,
                      width: 65*screenWidth/800,
                    ),
                  ),
                ),
              ),
              ///BOUTON Mer APPUYE
            ) :Positioned(
              top: 230.25*screenHeight/360,
              left: 722*screenWidth/800,
              child: Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () async{
                      await audioPlayer.stop();
                      setState(() {
                      audioisPlaying=false;
                    });
                    onMer();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/mer_appuye.svg",
                      height: 43*screenHeight/360,
                      width: 41*screenWidth/800,
                    ),
                  ),
                ),
              ),
            ),

            ///Bouton Defis

            !DefisButton ? Positioned(
              top: 289*screenHeight/360,
              left: 711*screenWidth/800,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                      offset: Offset(0, -2),

                    )
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () async{
                      await audioPlayer.stop();
                      setState(() {
                        audioisPlaying=false;
                      });
                      onDefis();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/Defis.svg",
                      height: 65*screenHeight/360,
                      width: 65*screenWidth/800,
                    ),
                  ),
                ),
              ),
              ///BOUTON Defis APPUYE
            ) :Positioned(
              top: 305*screenHeight/360,
              left: 733*screenWidth/800,
              child: Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () async{
                      await audioPlayer.stop();
                      setState(() {
                        audioisPlaying=false;
                      });
                      onDefis();
                    },
                    child: SvgPicture.asset(
                      "assets/livre/icons/Defis_appuye.svg",
                      height: 34*screenHeight/360,
                      width: 34*screenWidth/800,
                    ),
                  ),
                ),
              ),
            ),

            ///Bouton quitter
            Positioned(
              top: 13*screenHeight/360,
              left: 17*screenWidth/800,
              child:  GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  "assets/nav_buttons/back.svg",
                  height: 45*screenHeight/360,
                  width: 45*screenWidth/800,
                ),
              ),
            ),
            ///Bouton Son
            _hasSound() ? Positioned(
              top: 13*screenHeight/360,
              left: 395*screenWidth/800,
              child:  GestureDetector(
                onTap:playAudio,
                child: SvgPicture.asset(
                  "assets/livre/icons/book_sound.svg",
                  height: 45*screenHeight/360,
                  width: 45*screenWidth/800,
                ),
              ),
            ) : SizedBox.shrink(),
            ///Bouton Text Index
            Positioned(
              top: 321*screenHeight/360,
              left: 380*screenWidth/800,
              child:Text(
                "-${index}-",
                style: TextStyle(
                  fontSize: 20 * screenWidth / 800,
                  decoration: TextDecoration.none,
                  fontFamily: "AndikaNewBasic",
                  fontWeight: FontWeight.bold,
                  color: Color(HexColor("#0FA958")),

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
