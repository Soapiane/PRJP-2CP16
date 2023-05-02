import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:sqflite/sqflite.dart';
//----------------------------------------------
class TropheNonObtenu extends StatelessWidget {
  String Trophe;
  late Color? color;
  late String? asset;
  TropheNonObtenu({Key? key,required this.Trophe, this.color, this.asset}) : super(key: key);
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Center(
      child: Container(
        height: screenHeight*50/360 ,
        width:  screenWidth*298/800,
        decoration: BoxDecoration(
          color: color ?? Color(HexColor("B29200")),
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
          child:Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left:14*screenWidth/800 ),
                 child:SvgPicture.asset(
                    asset??"assets/trophies/trophy.svg",
                    height: (asset == null ? (30*4/5 ) : 7)* screenHeight / 360,
                    width: (asset == null ? (36*4/5 ) : 7)* screenWidth / 800,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(left: 23.0*screenWidth/800),
                      child: Text(
                         Trophe,
                        style: TextStyle(
                          fontSize: 12.5 * screenWidth / 800,
                          decoration: TextDecoration.none,
                          fontFamily: "AndikaNewBasic",
                          fontWeight  : FontWeight.bold,
                          color: Color(HexColor("#FFFFFF")),
                        ),
                      ),
                ),
              ),
              SizedBox(width: 10*screenWidth/800,)
            ],
          ),
        ),
      ),
    );
  }
}
class Trophies extends StatefulWidget {
  late List<String> Accomplis = [],NonAccomplis = [];


   Trophies({Key? key}) : super(key: key);

  @override
  State<Trophies> createState() => _TrophiesState();
}

class _TrophiesState extends State<Trophies> {
  Widget DefisRealise(){
    if(etendu){
      return TrophesEtendu(onPressedTend: onTendre,Accomplis: widget.NonAccomplis);
    }else{
      return TrophesTendu(onPressedTend: onTendre);
    }
  }
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  late bool etendu;
  void onTendre(){
    if(etendu){
      setState(() {
        etendu=false;
      });
    }else{
      setState(() {
        etendu=true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrophies();
    etendu=true;


  }

  void getTrophies() async {
    widget.Accomplis = [];
    widget.NonAccomplis = [];

    Database database = FirebaseAuth.instance.currentUser != null ? DatabaseRepository().database! : GuestRepository().database!;

    List<Map> trophiesCollected = await database.query(
        "trophy",
        where: "isCollected = ?",
        whereArgs: [1],
    );

    List<Map> trophiesNonCollected = await database.query(
      "trophy",
      where: "isCollected = ?",
      whereArgs: [0],
    );

    setState(() {
      for (Map trophy in trophiesCollected) {
        widget.Accomplis.add(trophy["title"]);
      }

      for (Map trophy in trophiesNonCollected) {
        widget.NonAccomplis.add(trophy["title"]);
      }
    });



  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(HexColor("#E5BC00")),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          width: screenWidth * 349 / 800,
          height: screenHeight * 287 / 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 22 * screenHeight / 360),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        "assets/trophies/trophies.svg",
                        height: 20 * screenHeight / 360,
                        width: 20 * screenWidth / 800,
                      ),

                      Text(
                        "Trophées",
                        style: TextStyle(
                          fontSize: 20 * screenWidth / 800,
                          decoration: TextDecoration.none,
                          fontFamily: "AndikaNewBasic",
                          fontWeight: FontWeight.bold,
                          color: Color(HexColor("#FFFFFF")),

                        ),
                      ),
                      SvgPicture.asset(
                        "assets/trophies/trophies.svg",
                        height: 20 * screenHeight / 360,
                        width: 20 * screenWidth / 800,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5 * screenHeight / 360),
                  child: Center(
                    child: Container(
                      height: 2*screenHeight/360,
                      width: screenWidth * 295 / 800,
                      decoration: const BoxDecoration(
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
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(top:5*screenHeight/360),
                    children: [
                        for(int i=0;i<widget.Accomplis.length;i++)Padding(
                          padding:  EdgeInsets.only(top: 11.0*screenHeight/360),
                          child: TropheNonObtenu(Trophe: widget.Accomplis[i]),
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: 14 * screenHeight / 360,bottom: 11 * screenHeight / 360),
                        child:DefisRealise(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class TrophesTendu extends StatefulWidget {
  VoidCallback onPressedTend;
  TrophesTendu({Key? key,required this.onPressedTend}) : super(key: key);

  @override
  State<TrophesTendu> createState() => _TrophesTenduState();
}

class _TrophesTenduState extends State<TrophesTendu> {
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Center(
      child: GestureDetector(
        onTap:  widget.onPressedTend,
        child: Container(
          height: screenHeight*24/360 ,
          width:  screenWidth*298/800,
          decoration: BoxDecoration(
            color: Color(HexColor("B29200")),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 2,
                offset: Offset(0,2),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[ Padding(
                      padding:  EdgeInsets.only(left: 39*screenWidth/800),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Trophées non obtenus",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.5 * screenWidth / 800,
                              decoration: TextDecoration.none,
                              fontFamily: "AndikaNewBasic",
                              fontWeight: FontWeight.bold,
                              color: Color(HexColor("#FFFFFF")),

                            ),

                          ),
                        ],
                      ),
                    ),
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 98*screenWidth/800),
                      child: SvgPicture.asset(
                        "assets/defis/Polygon_tendu.svg",
                        height: 11*screenHeight/360,
                        width: 12*screenWidth/800,
                      ),
                    ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
class TrophesEtendu extends StatelessWidget {
  VoidCallback onPressedTend;
  List<String> Accomplis;
  TrophesEtendu({Key? key,required this.onPressedTend,required this.Accomplis}) : super(key: key);
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Center(
      child: GestureDetector(
        onTap: onPressedTend,
        child: Container(
          width:  screenWidth*298/800,
          decoration: BoxDecoration(
            color: Color(HexColor("B29200")),
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
            child: Padding(
              padding:  EdgeInsets.only(top: 9.0*screenHeight/360,bottom: 9.0*screenHeight/360),
              child: Column(
                children: [
                  Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[ Padding(
                            padding:  EdgeInsets.only(left: 39*screenWidth/800),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Trophées non obtenus",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.5 * screenWidth / 800,
                                    decoration: TextDecoration.none,
                                    fontFamily: "AndikaNewBasic",
                                    fontWeight: FontWeight.bold,
                                    color: Color(HexColor("#FFFFFF")),

                                  ),

                                ),
                              ],
                            ),
                          ),
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 98*screenWidth/800),
                          child: GestureDetector(
                            onTap: onPressedTend,
                            child: SvgPicture.asset(
                              "assets/defis/Polygon_etendu.svg",
                              height: 11*screenHeight/360,
                              width: 12*screenWidth/800,
                            ),
                          ),
                        )
                      ]
                  ),
                  for(int i=0;i<Accomplis.length;i++)Center(
                      child: Container(
                        height: 40*screenHeight/360,
                        child:Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left:23*screenWidth/800 ),
                                child: SvgPicture.asset(
                                  "assets/trophies/point.svg",
                                  height: 7 * screenHeight / 360,
                                  width: 7 * screenWidth / 800,
                                ),
                              ),
                             Expanded(
                               child: Padding(
                                 padding:  EdgeInsets.only(left: 42.0*screenWidth/800),
                                 child: Text(
                                      Accomplis[i],
                                      style: TextStyle(
                                          fontSize: 12.5 * screenWidth / 800,
                                          fontFamily: "AndikaNewBasic",
                                          decorationThickness: 1,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                          color: Color(HexColor("#FFFFFF")),
                                          decorationColor: Colors.white
                                      ),
                                    ),
                               ),
                             ),
                            SizedBox(width: 10*screenWidth/800,)
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

