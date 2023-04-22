

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/AuthMainBody.dart';
import 'package:projet2cp/Authentication/AvatarSelectionBody.dart';
import 'package:projet2cp/Body.dart';
import 'package:projet2cp/Authentication/DifficultySelectionBody.dart';
import 'package:projet2cp/Authentication/LogInBody.dart';
import 'package:projet2cp/Authentication/RegisterBody.dart';
import 'package:projet2cp/Navigation/Zone/ZoneBody.dart';
import 'package:projet2cp/Navigation/ZoneSelectionBody.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Language.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:projet2cp/StandardWidgets.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/TextStyles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Zones.dart';

class MainScreen extends StatefulWidget {

  bool signedIn;


  MainScreen({super.key, this.signedIn = false});



  @override
  State<StatefulWidget> createState() {

    return _MainState();
  }

}


class _MainState extends State<MainScreen> {

  static const double blurRadius = 2;
  late StandardWidgets standardWidgets;
  late Body body;
  late ImageFilter blur;
  late AuthMainBody authMainBody;
  late LogInBody logInBody;
  late RegisterBody registerBody;
  late DifficultySelectionBody difficultySelectionBody;
  late ZoneSelectionBody zoneSelectionBody;
  late ZoneBody zoneBody;
  late AvatarSelectionBody avatarSelectionBody;


  // void goToZoneSelection(){
  //   setState(() {
  //     blur = ImageFilter.blur(
  //       sigmaX: 10,
  //       sigmaY: 10,
  //     );
  //
  //     zoneSelectionBody.lastScreen = body;
  //     body = zoneSelectionBody;
  //
  //   });
  // }




  void goToZoneBody(Zones zone){
    setState(() {

      zoneBody = ZoneBody(zone: zone);

      changeBodyWithBlur(newBody: zoneBody);

    });
  }

  void changeBodyWithBlur({required Body newBody, Body? lastBody}){
    setState(() {

      blur = ImageFilter.blur(
        sigmaX: blurRadius,
        sigmaY: blurRadius,
      );
      changeBody(newBody: newBody, lastBody: lastBody);
    });
  }

  void changeBodyWithNoBlur({required Body newBody, Body? lastBody}){
    setState(() {

      blur = ImageFilter.blur(
        sigmaX: 0,
        sigmaY: 0,
      );
      changeBody(newBody: newBody, lastBody: lastBody);
    });
  }


  void changeBody({required Body newBody, Body? lastBody}){
      lastBody ??= body;
      newBody.lastScreen = lastBody;
      body = newBody;

  }


  @override
  void initState() {
    super.initState();

    blur = ImageFilter.blur(
      sigmaX: 0,
      sigmaY: 0,
    );



    zoneSelectionBody = ZoneSelectionBody(
      onCardTap: goToZoneBody,
    );

    avatarSelectionBody = AvatarSelectionBody(
      onFinally: (){
        changeBodyWithBlur(newBody: zoneSelectionBody, lastBody: authMainBody);
      },
    );

    difficultySelectionBody = DifficultySelectionBody(
      onContinue: (){
          changeBodyWithNoBlur(newBody: avatarSelectionBody);
      },
    );


    registerBody = RegisterBody(
      onRegister: (){
        changeBodyWithNoBlur(newBody: difficultySelectionBody);
      }
    );


    logInBody = LogInBody(
      onConnexion: (){
        changeBodyWithBlur(newBody: zoneSelectionBody);
      },
      onRegister: (){
        changeBodyWithNoBlur(newBody: registerBody);
      },
    );


    authMainBody = AuthMainBody(
      onConnexionPressed: (){
        changeBodyWithNoBlur(newBody: logInBody);
      },
      onPlay: (){
        changeBodyWithBlur(newBody: zoneSelectionBody);
      },
    );





    body = widget.signedIn ? zoneSelectionBody : authMainBody;

  }


  @override
  Widget build(BuildContext context) {


    standardWidgets = StandardWidgets(context: context);
    Function? onBackButtonTapped;

    switch (body.toString()){
      case "AuthMainBody":{
        onBackButtonTapped = null;
      }
      break;
      case "ZoneSelectionBody":{
        onBackButtonTapped = () {
          setState(() {
            body.lastScreen = authMainBody;
            blur = ImageFilter.blur(
              sigmaX: body.lastScreen!.isBlured ? blurRadius : 0,
              sigmaY: body.lastScreen!.isBlured ? blurRadius : 0,
            );
            body = body.lastScreen ?? body;
            signOut();

          });
        };

      }
      break;
      default:{
        onBackButtonTapped = () {
          setState(() {
            blur = ImageFilter.blur(
              sigmaX: body.lastScreen!.isBlured ? blurRadius : 0,
              sigmaY: body.lastScreen!.isBlured ? blurRadius : 0,
            );
            body = body.lastScreen ?? body;
          });
        };
      }
      break;
    }



    // onBackButtonTapped = body.toString().compareTo("AuthMainBody") == 0 ? null : (){
    //   setState(() {
    //     blur = ImageFilter.blur(
    //       sigmaX: body.lastScreen!.isBlured ? blurRadius : 0,
    //       sigmaY: body.lastScreen!.isBlured ? blurRadius : 0,
    //     );
    //     body = body.lastScreen ?? body;
    //   });
    // };


    Widget foreground = createForeground(onBackButtonTapped: onBackButtonTapped);

    Widget background = Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/main_background.png"),
            fit: BoxFit.cover
        ),
      ),
      child: BackdropFilter(
        filter: blur,
        child: body,
      ),
    );



    return Scaffold(
      body: Stack(
        children: [
          background,

          foreground,



        ],
      ),
    );
  }

  Future<void> signOut() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await DatabaseRepository().signOut();
    } else {
      await GuestRepository().closeDB();
    }
  }




  Widget createForeground({
    Function? onBackButtonTapped
  }){
    return Stack(
      children: [
        standardWidgets.settingsButton(),

        standardWidgets.languageButton(Language.french),

        if (onBackButtonTapped!=null)standardWidgets.backButton(onBackButtonTapped: onBackButtonTapped),
      ],
    );
  }

}