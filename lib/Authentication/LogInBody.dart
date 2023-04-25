

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/Info/User.dart' as user;

class LogInBody extends Body {

  Function onRegister, onConnexion;
  LogInBody({Key? key, required this.onConnexion, required this.onRegister, super.lastScreen}) : super(key: key);


  
  

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
      rightButtonImagePath: "assets/closed_eye.svg",
      rightButtonPaddingHorizontal: 5,
      rightButtonPaddingVertical: 5,
    );


    
    return MaterialApp(
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
                        print("EMAIL: ${email.second.controller?.text}");
                        print("PASSWORD: ${password.second.controller?.text}");

                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.second.controller!.text,
                          password: password.second.controller!.text,
                        ).then((value) => _onConnexion()).catchError((e) => print("Error: $e"));


                    },
                    ).first,
                    textGenerator.generateTextView(
                      texts: ["pas de compte?", " s'inscrire! "],
                      fontSize: 11,
                      textStyle: TextStyle(
                        color: color.Color.white.color,
                        fontSize: 11,
                        fontFamily: "PoppinsMedium"
                      ),
                      linkStyle: TextStyle(
                        color: color.Color.white.color,
                        fontSize: 11,
                        fontFamily: "PoppinsBold",
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
      await DatabaseRepository().openDB();
      await DatabaseRepository().download();
      onConnexion.call();
    }



}
