


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/MainScreen.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Couple.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/Navigation/Loading.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Info/User.dart' as user;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterBody extends Body {


  Function onRegister;
  Function(String) showErrorDialog;
  late Couple userName;
  late BuildContext? mainContext;
  RegisterBody({Key? key, this.mainContext,required this.onRegister, required this.showErrorDialog, super.lastScreen}) : super(key: key);





  @override
  Widget build(BuildContext context) {




    ImageGenerator imageGenerator = ImageGenerator(context: context);
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);

    Margin formMargin = Margin(context: context, bottom: 19);


    userName = textGenerator.generateTextField(
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
            imagePath: "assets/terra/earth_hi.svg",
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  userName.first,
                  email.first,
                  password.first,
                  buttonGenerator.generateTextButton(
                    height: 39,
                    width: 257,
                    backgroundColor: color.Color.yellow,
                    text: "Inscription",
                    margin: formMargin,
                    onTap: (){

                      Loading.ShowLoading(mainContext!);
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.second.controller!.text,
                        password: password.second.controller!.text,
                      ).then((value) => register()).catchError((e) {
                        FirebaseAuthException error = e as FirebaseAuthException;
                        if (checkErrors(error, ["email-already-in-use", "invalid-email", "operation-not-allowed"])
                            || e.toString().contains("Given String is empty or null")) {
                          showErrorDialog("Probléme dans l'email ou le mot de passe");
                        } else if (checkErrors(error, ["weak-password"])) {
                          showErrorDialog("Le mot de passe est trop faible");
                        } else if (e.toString().contains("A network error")){
                          showErrorDialog(MainScreen.networkErrorString);
                        } else {
                          showErrorDialog("Une erreur s'est produite");
                        }
                      });
                    },
                  ).first,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> register() async {
    user.User().setName(userName.second.controller!.text);
    await DatabaseRepository().openDB();
    await DatabaseRepository().upload();
    onRegister.call();
  }


}