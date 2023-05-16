

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/MainScreen.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/Navigation/Loading.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/Info/User.dart' as user;

class LogInBody extends Body {

  Function onRegister, onConnexion;
  Function(String) showErrorDialog;
  late BuildContext? mainContext;
  LogInBody({Key? key, this.mainContext, required this.onConnexion, required this.onRegister, required this.showErrorDialog, super.lastScreen}) : super(key: key);


  
  

  @override
  Widget build(BuildContext context) {




    ImageGenerator imageGenerator = ImageGenerator(context: context);
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);

    Margin formMargin = Margin(context: context, bottom: 13);

    final email = textGenerator.generateTextField(
      height: 39,
      width: 257,
      hintText: "E-mail",
      icon: Icons.person,
      margin: formMargin,
    );
    final password = textGenerator.generateTextField(
      height: 39,
      width: 257,
      hintText: "Mot de passe",
      icon: Icons.password,
      margin: formMargin,
      hide: true,
    );

    bool checkErrors(FirebaseAuthException error, List<String> codes) {

      for (String element in codes) {
        if (error.code.compareTo(element) == 0) {
          return true;
        }
      }
      return false;
    }


    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green),
      ),
      home: Stack(
          children: [
            imageGenerator.generateImage(
              height: 130,
              width: 133,
              xPos: 569,
              yPos: 209,
              imagePath: "assets/terra/earth_sleeping.svg",
            ),

            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    email.first,
                    password.first,
                    buttonGenerator.generateTextButton(
                      height: 39,
                      width: 257,
                      backgroundColor: color.Color.yellow,
                      text: "Connexion",
                      margin: formMargin,
                      onTap: (){
                        Loading.ShowLoading(mainContext!);
                        //trying to log in
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.second.controller!.text,
                          password: password.second.controller!.text,
                        ).then((value) => _onConnexion()).catchError((e) {
                          FirebaseAuthException error = e as FirebaseAuthException;
                          if (checkErrors(error, ["wrong-password", "invalid-email", "user-disabled", "user-not-found"])
                          || e.toString().contains("Given String is empty or null")) {
                            //if email or password are wrong
                            showErrorDialog("Email ou mot de passe incorrect");
                          } else if (e.toString().contains("A network error")){
                            //if network error
                            showErrorDialog(MainScreen.networkErrorString);
                          } else {
                            //if other problems
                            showErrorDialog("Une erreur s'est produite");
                          }
                        });


                    },
                    ).first,
                    textGenerator.generateTextView(
                      texts: ["pas de compte?", " s'inscrire! "],
                      fontSize: 16,
                      textStyle: TextStyle(
                        color: color.Color.white.color,
                        fontSize: 16,
                        fontFamily: "AndikaNewBasic"
                      ),
                      linkStyle: TextStyle(
                        color: color.Color.white.color,
                        fontSize: 16,
                        fontFamily: "AndikaNewBasicBold",
                        decoration: TextDecoration.underline,
                      ),
                      onSpansTap: [
                        onRegister,
                      ],
                    ).first,
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }


    void _onConnexion() async {
    //opens the user db
      await DatabaseRepository().openDB();
      //downlloads the user info from the cloud
      await DatabaseRepository().download();
      //excute changes in the MainScreen
      onConnexion.call();
    }



}
