

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/AuthMainBody.dart';
import 'package:projet2cp/Authentication/AvatarSelectionBody.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/Authentication/DifficultySelectionBody.dart';
import 'package:projet2cp/Authentication/LogInBody.dart';
import 'package:projet2cp/Authentication/RegisterBody.dart';
import 'package:projet2cp/Navigation/Mode.dart';
import 'package:projet2cp/Navigation/ModeSelectionBody.dart';
import 'package:projet2cp/Navigation/Warning.dart';
import 'package:projet2cp/Navigation/Zone/ZoneBody.dart';
import 'package:projet2cp/Navigation/ZoneSelectionBody.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Info/Language.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:projet2cp/StandardWidgets.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/TextStyles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  late ModeSelectionBody modeSelectionBody;
  late ZoneSelectionBody zoneSelectionBody;
  late ZoneBody zoneBody;
  late AvatarSelectionBody avatarSelectionBody;
  late Widget challengesButton, trophiesWidget;







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

    modeSelectionBody = ModeSelectionBody(
      onModeSelected: (mode){
        if (mode == Mode.adventure) {
          changeBodyWithBlur(newBody: zoneSelectionBody);
        }
      },
    );

    avatarSelectionBody = AvatarSelectionBody(
      onFinally: (){


        changeBodyWithBlur(newBody: modeSelectionBody, lastBody: authMainBody);
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
        changeBodyWithBlur(newBody: modeSelectionBody);
      },
      onRegister: (){
        changeBodyWithNoBlur(newBody: registerBody);
      },
    );


    authMainBody = AuthMainBody(
      onConnexionPressed: (){
        goToLogIn();
      },
      onPlay: (){
        changeBodyWithBlur(newBody: modeSelectionBody);
      },
    );





    body = widget.signedIn ? modeSelectionBody : authMainBody;





  }


  @override
  Widget build(BuildContext context) {


    standardWidgets = StandardWidgets(context: context);
    Function? onBackButtonTapped, onChallengeButtonTapped, onTrophiesButtonTapped;


    switch (body.toString()){
      case "AuthMainBody":{
        onBackButtonTapped = null;
      }
      break;
      case "DifficultySelectionBody":{
        onBackButtonTapped = null;
      }
      break;
      case "AvatarSelectionBody":{
        onBackButtonTapped = null;
      }
      break;
      case "ModeSelectionBody":{
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
        if (body.toString().compareTo("ZoneSelectionBody") == 0 || body.toString().compareTo("ZoneBody") == 0 ) {
          onChallengeButtonTapped = () {
            print("challenges tapped");
          };
          onTrophiesButtonTapped = () {
            print("trophies tapped");
          };
        }
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


    Widget foreground = createForeground(
      onBackButtonTapped: onBackButtonTapped,
      onChallengeButtonTapped: onChallengeButtonTapped,
      onTrophiesButtonTapped: onTrophiesButtonTapped,
    );

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
    Function? onBackButtonTapped,
    Function? onChallengeButtonTapped,
    Function? onTrophiesButtonTapped,
  }){
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);
    double topPadding = buttonGenerator.calculateY(10);
    double verticalPadding = buttonGenerator.calculateX(21);
    return Padding(
      padding: EdgeInsets.only(top: topPadding, left: verticalPadding, right: verticalPadding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          onBackButtonTapped!=null ? standardWidgets.backButton(onBackButtonTapped: onBackButtonTapped) : SizedBox.shrink(),
          onChallengeButtonTapped!=null ? standardWidgets.challengesButton(onChallengesButtonTapped: onChallengeButtonTapped) : SizedBox.shrink(),
          onTrophiesButtonTapped!=null ? standardWidgets.trophiesButton(onTrophiesButtonTapped: onTrophiesButtonTapped) : SizedBox.shrink(),
          standardWidgets.settingsButton(),

        ],
      ),
    );
  }

  void goToLogIn() async {

    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      changeBodyWithNoBlur(newBody: logInBody);
    } else {
      setState(() {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => Warning(onOk: (){Navigator.of(context).pop();}, text: "Pas de connexion internet!",),
        );
      });
    }

  }





}