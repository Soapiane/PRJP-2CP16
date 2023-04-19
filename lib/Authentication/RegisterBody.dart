


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/Body.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/Color.dart' as color;

class RegisterBody extends Body {


  Function onRegister;
  RegisterBody({Key? key, required this.onRegister, super.lastScreen}) : super(key: key);





  @override
  Widget build(BuildContext context) {




    ImageGenerator imageGenerator = ImageGenerator(context: context);
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);

    Margin formMargin = Margin(context: context, bottom: 19);


    final userName = textGenerator.generateTextField(
      height: 39,
      width: 257,
      hintText: "Nom d'utilisateur",
      icon: Icons.person,
      margin: formMargin,
    );
    final email = textGenerator.generateTextField(
      height: 39,
      width: 257,
      hintText: "E-mail",
      icon: Icons.email,
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
            height: 157,
            width: 134,
            xPos: 98,
            yPos: 153,
            imagePath: "assets/earth_hi.svg",
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  userName.widget,
                  email.widget,
                  password.widget,
                  buttonGenerator.generateTextButton(
                    height: 39,
                    width: 257,
                    backgroundColor: color.Color.yellow,
                    text: "inscription",
                    margin: formMargin,
                    onTap: (){

                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.textField.controller!.text,
                        password: password.textField.controller!.text,
                      ).then((value) => onRegister.call()).catchError((e) => print("Error: $e"));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}