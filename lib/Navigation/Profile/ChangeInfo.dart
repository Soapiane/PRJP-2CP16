import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:projet2cp/Info/User.dart';
import 'package:projet2cp/Navigation/Loading.dart';
import 'package:projet2cp/Navigation/Warning.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projet2cp/Info/User.dart' as user;
class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {

  final myController1 = TextEditingController(), myController2 = TextEditingController();


  Future<void> changePassword() async {

    bool checkErrors(FirebaseAuthException error, List<String> codes) {

      for (String element in codes) {
        if (error.code.compareTo(element) == 0) {
          return true;
        }
      }
      return false;
    }

    String password = myController1.text, confirmPassword = myController2.text;

    Loading.ShowLoading(context);
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {

      Loading.HideLoading(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Warning(text: "Pas de connexion internet" ,onOk: (){Navigator.pop(context);},);
          });
    } else {
      if (password.isEmpty || confirmPassword.isEmpty
      || password.compareTo(confirmPassword) != 0) {
        showDialog(
            context: context,
            builder: (context){
              return Warning(
                  text: "Probléme dans le mot de passe",
                  onOk: (){Navigator.pop(context);}
              );
            }
        );
      } else {
        FirebaseAuth.instance.currentUser!.updatePassword(password)
        .then((value) {
          Loading.HideLoading(context);
          Navigator.pop(context);
        }).catchError((error){
          if (checkErrors(error, ["weak-password"])) {
            showDialog(
                context: context,
                builder: (context){
                  return Warning(
                      text: "Le mot de passe est trop faible",
                      onOk: (){Navigator.pop(context);}
                  );
                }
            );
          } else {
            showDialog(
                context: context,
                builder: (context){
                  return Warning(
                      text: "Une erreur s'est produite",
                      onOk: (){Navigator.pop(context);}
                  );
                }
            );
          }
        });
      }
    }
  }

  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: (){Navigator.pop(context);},
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  color: Colors.transparent,
                ),
              ),
              SingleChildScrollView(
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
                    height: screenHeight*208/360,
                    width: screenWidth*303/800,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child:  Column(
                            children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 27*screenHeight/360),
                                  child: Center(
                                    child: Text(
                                      "Modifier le mot de passe",
                                      style: TextStyle(
                                        fontSize: 16*screenWidth/800,

                                        decoration: TextDecoration.none,
                                        fontFamily: "AndikaNewBasic",
                                        fontWeight: FontWeight.bold,
                                        color: Color(HexColor("#404040")),

                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.only(top: 5 * screenHeight / 360),
                                child: Center(
                                  child: Container(
                                    height: 1*screenHeight/360,
                                    width: screenWidth * 200 / 800,
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
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: 15*screenHeight/360),
                                child: Center(
                                  child: Container(
                                    height: screenHeight*31/360 ,
                                    width:  screenWidth*233/800,
                                    decoration: BoxDecoration(
                                      color: Color(HexColor("FFFFFF")),
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
                                        child:Padding(
                                          padding:  EdgeInsets.only(left: 20*screenWidth/800),
                                          child: Material(
                                            child: TextField(
                                              controller: myController1,
                                              textAlign: TextAlign.center,
                                              obscureText:true,
                                              style: TextStyle(
                                                color:Color(HexColor("919090")),
                                                fontSize: 14*screenWidth/800,
                                                decoration: TextDecoration.none,
                                                fontFamily: "AndikaNewBasic",
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlignVertical: TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Mot de Passe',
                                                hintStyle: TextStyle(
                                                  color:Color(HexColor("919090")),
                                                  fontSize: 14*screenWidth/800,
                                                  decoration: TextDecoration.none,
                                                  fontFamily: "AndikaNewBasic",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: 14*screenHeight/360),
                                child: Center(
                                  child: Container(
                                    height: screenHeight*31/360 ,
                                    width:  screenWidth*233/800,
                                    decoration: BoxDecoration(
                                      color: Color(HexColor("FFFFFF")),
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
                                      borderRadius: BorderRadius.circular(15),
                                      child:Padding(
                                        padding:  EdgeInsets.only(left: 20*screenWidth/800),
                                        child: Material(
                                          child: TextField(
                                            controller: myController2,
                                            textAlign: TextAlign.center,
                                            obscureText:true,
                                            style: TextStyle(
                                              fontSize: 14*screenWidth/800,
                                              decoration: TextDecoration.none,
                                              fontFamily: "AndikaNewBasic",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlignVertical: TextAlignVertical.center,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Confirmer la saisie',
                                              hintStyle: TextStyle(
                                                color:Color(HexColor("919090")),
                                                fontSize: 14*screenWidth/800,
                                                decoration: TextDecoration.none,
                                                fontFamily: "AndikaNewBasic",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: 14*screenHeight/360),
                                child: Center(
                                  child: Container(
                                    height: screenHeight*31/360 ,
                                    width:  screenWidth*233/800,
                                    decoration: BoxDecoration(
                                      color: Color(HexColor("F2F609")),
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
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll<Color>(Color(HexColor("F2F609"))),

                                          ),
                                          onPressed: (){changePassword();},
                                            child: Center(
                                              child: Text(
                                                "Confirmer",
                                                style: TextStyle(
                                                  fontSize: 16*screenWidth/800,

                                                  decoration: TextDecoration.none,
                                                  fontFamily: "AndikaNewBasic",
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(HexColor("#404040")),

                                                ),
                                              ),
                                        )

                                    ),
                                  ),
                                ),
                              ),

                                ),
                            ],
                          ),
                        )
                    ),
              ),
            ],
          )
      ),
    );
  }
}
class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  
  final myController = TextEditingController();



  void changeEmail(String newEmail) async {
    bool checkErrors(FirebaseAuthException error, List<String> codes) {

      for (String element in codes) {
        if (error.code.compareTo(element) == 0) {
          return true;
        }
      }
      return false;
    }

    Loading.ShowLoading(context);
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {

      Loading.HideLoading(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Warning(text: "Pas de connexion internet" ,onOk: (){Navigator.pop(context);},);
          });
    } else {
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseAuth.instance.currentUser!.updateEmail(newEmail).then((value) {
          Loading.HideLoading(context);
          Navigator.pop(context);
        }).catchError((error) {
          print(error.toString());
          Loading.HideLoading(context);
          if (checkErrors(error, ["email-already-in-use", "invalid-email", "operation-not-allowed"])
              || error.toString().contains("Given String is empty or null")) {
            showDialog(
                context: context,
                builder: (context){
                  return Warning(
                      text: "Probléme dans l'email ou le mot de passe",
                      onOk: (){Navigator.pop(context);}
                  );
                }
            );
          } else {
            showDialog(
                context: context,
                builder: (context){
                  return Warning(
                      text: "Une erreur s'est produite",
                      onOk: (){Navigator.pop(context);}
                  );
                }
            );
          }
        });
      }
    }
  }
  
  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: (){Navigator.pop(context);},
                child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  color: Colors.transparent,
                ),
              ),
              SingleChildScrollView(
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
                    height: screenHeight*177/360,
                    width: screenWidth*303/800,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child:  Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 27*screenHeight/360),
                            child: Center(
                              child: Text(
                                "Modifier mes informations",
                                style: TextStyle(
                                  fontSize: 16*screenWidth/800,

                                  decoration: TextDecoration.none,
                                  fontFamily: "AndikaNewBasic",
                                  fontWeight: FontWeight.bold,
                                  color: Color(HexColor("#404040")),

                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5 * screenHeight / 360),
                            child: Center(
                              child: Container(
                                height: 1*screenHeight/360,
                                width: screenWidth * 200 / 800,
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
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 15*screenHeight/360),
                            child: Center(
                              child: Container(
                                height: screenHeight*31/360 ,
                                width:  screenWidth*233/800,
                                decoration: BoxDecoration(
                                  color: Color(HexColor("FFFFFF")),
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
                                  child:Padding(
                                    padding:  EdgeInsets.only(left: 20*screenWidth/800),
                                    child: Material(
                                      child: TextField(
                                        controller: myController,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14*screenWidth/800,
                                          decoration: TextDecoration.none,
                                          fontFamily: "AndikaNewBasic",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlignVertical: TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'nouvelle adresse Email',
                                          hintStyle: TextStyle(
                                            color:Color(HexColor("919090")),
                                            fontSize: 14*screenWidth/800,
                                            decoration: TextDecoration.none,
                                            fontFamily: "AndikaNewBasic",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 14*screenHeight/360),
                            child: Center(
                              child: Container(
                                height: screenHeight*31/360 ,
                                width:  screenWidth*233/800,
                                decoration: BoxDecoration(
                                  color: Color(HexColor("F2F609")),
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
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll<Color>(Color(HexColor("F2F609"))),

                                      ),
                                      onPressed: (){changeEmail(myController.text);},
                                      child: Center(
                                        child: Text(
                                          "Confirmer",
                                          style: TextStyle(
                                            fontSize: 16*screenWidth/800,

                                            decoration: TextDecoration.none,
                                            fontFamily: "AndikaNewBasic",
                                            fontWeight: FontWeight.bold,
                                            color: Color(HexColor("#404040")),

                                          ),
                                        ),
                                      )

                                  ),
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    )
                ),
              ),
            ],
          )
      ),
    );
  }
}

class UserName extends StatefulWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {

  final myController = TextEditingController();

  int HexColor(String color){
    String newColor="0xff"+color;
    newColor=newColor.replaceAll("#", "");
    int finalColor=int.parse(newColor);
    return finalColor;
  }


  void onSuccess(String newName) async {
    await user.User().setName(newName);
    Loading.HideLoading(context);
    Navigator.pop(context);

  }

  Future<void> changeUserName(String newName) async {



    Loading.ShowLoading(context);
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      Loading.HideLoading(context);
      showDialog(context: context, builder: (context) => Warning(text: "Pas de connexion internet!",onOk: (){Navigator.pop(context);},));
    } else {
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseDatabase(databaseURL: DatabaseRepository.databaseLink)
            .reference()
            .child("users").child(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "name": newName,
        }).then((value) {
          onSuccess(newName);
        }).catchError((error) {
          Loading.HideLoading(context);
          showDialog(context: context, builder: (context) => Warning(text: "Une erreur s'est produite!",onOk: (){Navigator.pop(context);},));
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: (){Navigator.pop(context);},
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  color: Colors.transparent,
                ),
              ),
              SingleChildScrollView(
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
                    height: screenHeight*177/360,
                    width: screenWidth*303/800,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child:  Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 27*screenHeight/360),
                            child: Center(
                              child: Text(
                                "Modifier mes informations",
                                style: TextStyle(
                                  fontSize: 16*screenWidth/800,

                                  decoration: TextDecoration.none,
                                  fontFamily: "AndikaNewBasic",
                                  fontWeight: FontWeight.bold,
                                  color: Color(HexColor("#404040")),

                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5 * screenHeight / 360),
                            child: Center(
                              child: Container(
                                height: 1*screenHeight/360,
                                width: screenWidth * 200 / 800,
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
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 15*screenHeight/360),
                            child: Center(
                              child: Container(
                                height: screenHeight*31/360 ,
                                width:  screenWidth*233/800,
                                decoration: BoxDecoration(
                                  color: Color(HexColor("FFFFFF")),
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
                                  child:Padding(
                                    padding:  EdgeInsets.only(left: 20*screenWidth/800),
                                    child: Material(
                                      child: TextField(
                                        controller: myController,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14*screenWidth/800,
                                          decoration: TextDecoration.none,
                                          fontFamily: "AndikaNewBasic",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlignVertical: TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Nouveau Nom d'utilisateur",
                                          hintStyle: TextStyle(
                                            color:Color(HexColor("919090")),
                                            fontSize: 14*screenWidth/800,
                                            decoration: TextDecoration.none,
                                            fontFamily: "AndikaNewBasic",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 14*screenHeight/360),
                            child: Center(
                              child: Container(
                                height: screenHeight*31/360 ,
                                width:  screenWidth*233/800,
                                decoration: BoxDecoration(
                                  color: Color(HexColor("F2F609")),
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
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll<Color>(Color(HexColor("F2F609"))),

                                      ),
                                      onPressed: (){changeUserName(myController.text);},
                                      child: Center(
                                        child: Text(
                                          "Confirmer",
                                          style: TextStyle(
                                            fontSize: 16*screenWidth/800,

                                            decoration: TextDecoration.none,
                                            fontFamily: "AndikaNewBasic",
                                            fontWeight: FontWeight.bold,
                                            color: Color(HexColor("#404040")),

                                          ),
                                        ),
                                      )

                                  ),
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    )
                ),
              ),
            ],
          )
      ),
    );
  }
}
