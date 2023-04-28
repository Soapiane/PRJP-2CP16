import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
//----------------------------------------------
class TacheNonRealise extends StatelessWidget {
  String tache;
  FonAjouterTache onRetirer;
  TacheNonRealise({Key? key,required this.tache,required this.onRetirer}) : super(key: key);
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
          color: Color(HexColor("19806D")),
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
                padding:  EdgeInsets.only(left:22*screenWidth/800 ),
                child: GestureDetector(
                  onTap: (){
                    onRetirer(this.tache);
                  },
                  child: SvgPicture.asset(
                    "assets/defis/Unchecked-circle.svg",
                    height: 20 * screenHeight / 360,
                    width: 20 * screenWidth / 800,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    tache,
                    textAlign: TextAlign.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
typedef  FonAjouterTache=void Function( String);
class Defis extends StatefulWidget {
  List<String> NonRea=[];
  List<String> Rea=[];
  Defis({Key? key,required this.NonRea,required this.Rea}) : super(key: key);

  @override
  State<Defis> createState() => _DefisState();
}

class _DefisState extends State<Defis> {

  Widget DefisRealise(){
    if(etendu){
      return Etendu(onPressedTend: onTendre,Rea: widget.Rea,Retirer: onAjouterTache,NonRea:widget.NonRea);
    }else{
      return Tendu(onPressedTend: onTendre,);
    }
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
  void onAjouterTache(String tache){
    setState(() {
      widget.NonRea.add(tache);
      widget.Rea.remove(tache);
    });
  }
  void onEnleverTache(String tache){
    setState(() {
      widget.Rea.add(tache);
      widget.NonRea.remove(tache);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    etendu=false;
  }
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
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(HexColor("#25BEA1")),
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
                        "assets/defis/defi.svg",
                        height: 20 * screenHeight / 360,
                        width: 20 * screenWidth / 800,
                      ),

                      Text(
                        "Défis",
                        style: TextStyle(
                          fontSize: 20 * screenWidth / 800,
                          decoration: TextDecoration.none,
                          fontFamily: "AndikaNewBasic",
                          fontWeight: FontWeight.bold,
                          color: Color(HexColor("#FFFFFF")),

                        ),
                      ),
                      SvgPicture.asset(
                        "assets/defis/defi.svg",
                        height: 20 * screenHeight / 360,
                        width: 20 * screenWidth / 800,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12 * screenHeight / 360),
                  child: Center(
                    child: Container(
                      height: 2,
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
                      for(int i=0;i<widget.NonRea.length;i++)Padding(
                          padding: EdgeInsets.only(top: 11 * screenHeight / 360),
                          child: TacheNonRealise(tache: widget.NonRea[i],onRetirer:onEnleverTache)
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
class Etendu extends StatelessWidget {
  VoidCallback onPressedTend;
  List<String> Rea,NonRea;
  FonAjouterTache Retirer;
  Etendu({Key? key,required this.onPressedTend,required this.Rea,required this.Retirer,required this.NonRea}) : super(key: key);
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
          width:  screenWidth*298/800,
          decoration: BoxDecoration(
            color: Color(HexColor("19806D")),
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
                                  "Défis réalisés",
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
                          padding:  EdgeInsets.only(left: 133*screenWidth/800),
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
                  for(int i=0;i<Rea.length;i++)Center(
                        child: Container(
                          height: 50*screenHeight/360,
                          child:Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left:10*screenWidth/800 ),
                                child: GestureDetector(
                                  onTap: (){
                                    Retirer(Rea[i]);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/defis/Checked_circle.svg",
                                    height: 20 * screenHeight / 360,
                                    width: 20 * screenWidth / 800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5*screenWidth/800,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    Rea[i],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.5 * screenWidth / 800,
                                      fontFamily: "AndikaNewBasic",
                                      decorationThickness: 1,
                                        decorationStyle: TextDecorationStyle.solid,
                                      decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.bold,
                                      color: Color(HexColor("#FFFFFF")),
                                      decorationColor: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10*screenWidth/800,
                              ),
                            ],
                          ),
                        )
                    ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
//---------------------------------------
class Tendu extends StatefulWidget {
  VoidCallback onPressedTend;
   Tendu({Key? key,required this.onPressedTend}) : super(key: key);

  @override
  State<Tendu> createState() => _TenduState();
}

class _TenduState extends State<Tendu> {
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
        height: screenHeight*24/360 ,
        width:  screenWidth*298/800,
        decoration: BoxDecoration(
          color: Color(HexColor("19806D")),
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
                          "Défis réalisés",
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
                  padding:  EdgeInsets.only(left: 133*screenWidth/800),
                  child: GestureDetector(
                    onTap: widget.onPressedTend,
                    child: SvgPicture.asset(
                      "assets/defis/Polygon_tendu.svg",
                      height: 11*screenHeight/360,
                      width: 12*screenWidth/800,
                    ),
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}

