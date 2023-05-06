import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projet2cp/Info/User.dart';
import 'package:projet2cp/Info/User.dart' as user;
import 'package:projet2cp/Navigation/Profile/ChangeAvatar.dart';
import 'package:projet2cp/Navigation/Profile/ChangeInfo.dart';

class Profile extends StatefulWidget {
  late String Nom,Email;
  Profile({Key? key}) : super(key: key){
    Nom = user.User().name;
    Email = FirebaseAuth.instance.currentUser!.email!;
  }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  Future<void> onChangeName() async {
    await showDialog(context: context, builder: (context) => UserName() , barrierDismissible: true);
    setState(() {
      widget.Nom = user.User().name;
      widget.Email = FirebaseAuth.instance.currentUser!.email!;
    });
  }
  void onChangeEmail(){
    showDialog(context: context, builder: (context) => Email() , barrierDismissible: true);
  }
  void onChangePassword(){
    showDialog(context: context, builder: (context) => Password() , barrierDismissible: true);
  }
  void onChangeAvatar() {
    showDialog(context: context, builder: (context) => ChangeAvatar() , barrierDismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final heightCon=0.836*screenHeight;
    final widthCon=screenWidth*3/8;
    final loginBack=Image.asset('assets/profile/background.png');
    return  GestureDetector(
      onTap: (){},
      child: Center(
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
                  Container(
                    height: 108*screenHeight/360,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:  loginBack.image,
                          fit: BoxFit.fill,
                        )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top:6*screenHeight/360),
                          child: Center(
                            child: Text(
                              "Profil",
                              style: TextStyle(
                                fontSize: 20*screenWidth/800,

                                decoration: TextDecoration.none,
                                fontFamily: "AndikaNewBasic",
                                fontWeight: FontWeight.bold,
                                color: Color(HexColor("#404040")),

                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top:1.0*screenHeight/360),
                          child: Center(
                            child: Container(
                              height: 1,
                              width: screenWidth*0.065,
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
                        GestureDetector(
                          onTap: onChangeAvatar,
                          child: Padding(
                            padding:  EdgeInsets.only(top: 6.0*screenHeight/360),
                            child: Center(
                              child:SvgPicture.asset(user.User().avatar.getImagePath(),height: 57*screenHeight/360,width: 55*screenWidth/800,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  /// NOM UTILISATEUR
                  Padding(
                    padding:  EdgeInsets.only(top: 10*screenHeight/360),
                    child: Center(
                      child: Text(
                        "Nom d’utilisateur :",
                        style: TextStyle(
                          fontSize: 11.5*screenWidth/800,
                          decorationColor:Color(HexColor("#404040")),
                          fontFamily: "AndikaNewBasic",
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          color: Color(HexColor("#404040")),

                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: screenWidth*105/800,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(HexColor("#404040")),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  /// CONTAINER UTILISATEUR ET ICONE
                  Padding(
                    padding:  EdgeInsets.only(top:6.0*screenHeight/360),
                    child: EspaceNom(couleur: HexColor("#404040"),couleurCon:HexColor("#FFFFFF"), path: "assets/profile/pencil.svg", Nom: widget.Nom,function: onChangeName,),
                  ),
                  ///EMAIL
                  Padding(
                    padding:  EdgeInsets.only(top: 5*screenHeight/360),
                    child: Center(
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 11.5*screenWidth/800,
                          decorationColor:Color(HexColor("#404040")),
                          fontFamily: "AndikaNewBasic",
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Color(HexColor("#404040")),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: screenWidth*32/800,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(HexColor("#404040")),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top:6.0*screenHeight/360),
                    child: EspaceNom(couleur: HexColor("#404040"),couleurCon:HexColor("#FFFFFF"), path: "assets/profile/pencil.svg", Nom: widget.Email,function: onChangeEmail,),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:22.0*screenHeight/360),
                    child: EspaceNom(couleur: HexColor("#404040"),couleurCon:HexColor("#F2F609"), Nom: "Modifier le mot de passe",function: onChangePassword,),
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }
}
class EspaceNom extends StatelessWidget {
  int couleur,couleurCon;
  String? path;
  String Nom;
  VoidCallback function;

  EspaceNom({Key? key,required this.couleur, this.path,required this.Nom,required this.couleurCon,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return   Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 20*screenWidth/800),
          child: GestureDetector(
            onTap: () {
              path == null ? function() : null;
              },
            child: Container(
              decoration: BoxDecoration(
                color: Color(couleurCon),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 2,
                    offset: Offset(0,2),
                  )
                ],
              ),
              height: 31*screenHeight/360,
              width: 233*screenWidth/800,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Nom,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize:screenWidth*14/800,
                        decorationColor:Color(couleur),
                        fontFamily: "AndikaNewBasic",
                        fontWeight: FontWeight.bold,
                        color: Color(couleur),
                      ),
                    ),
                  ],

                ),
              ),
            ),
          ),
        ),
        path != null ? Padding(
          padding:  EdgeInsets.only(left:9.0*screenWidth/800),
          child: GestureDetector(
            onTap: function,
            child: SvgPicture.asset(
              path!,
              height: 21*screenHeight/360,
              width: 21*screenWidth/800,
            ),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
