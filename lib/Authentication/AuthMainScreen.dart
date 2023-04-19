

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/AuthMainBody.dart';
import 'package:projet2cp/Authentication/Body.dart';
import 'package:projet2cp/Authentication/LogInBody.dart';
import 'package:projet2cp/Authentication/RegisterBody.dart';
import 'package:projet2cp/Authentication/Zone/ZoneMainScreen.dart';
import 'package:projet2cp/Authentication/ZoneSelectionBody.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Language.dart';
import 'package:projet2cp/StandardWidgets.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/TextStyles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Zones.dart';

class AuthMainScreen extends StatefulWidget {



  AuthMainScreen({super.key});



  @override
  State<StatefulWidget> createState() {

    return _AuthMainState();
  }

}


class _AuthMainState extends State<AuthMainScreen> {


  late StandardWidgets standardWidgets;
  late Body body;
  late ImageFilter blur;
  late AuthMainBody authMainBody;
  late LogInBody logInBody;
  late RegisterBody registerBody;
  late ZoneSelectionBody zoneSelectionBody;
  late ZoneMainScreen zoneMainScreen;


  void goToZoneSelection(){
    setState(() {
      blur = ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      );

      zoneSelectionBody.lastScreen = body;
      body = zoneSelectionBody;

    });
  }


  void goToZoneMainScreen(Zones zone){
    setState(() {
      blur = ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      );

      zoneMainScreen = ZoneMainScreen(zone: zone);

      zoneMainScreen.lastScreen = zoneSelectionBody;

      body = zoneMainScreen;

    });
  }


  @override
  void initState() {
    super.initState();

    blur = ImageFilter.blur(
      sigmaX: 0,
      sigmaY: 0,
    );



    zoneSelectionBody = ZoneSelectionBody(
      onCardTap: goToZoneMainScreen,
    );



    registerBody = RegisterBody(
      onRegister: (){
        goToZoneSelection();
      }
    );

    zoneSelectionBody.lastScreen = registerBody;

    logInBody = LogInBody(
      onConnexion: (){
        goToZoneSelection();
      },
      onRegister: (){
        setState(() {
          body = registerBody;
        });
      },
    );

    registerBody.lastScreen = logInBody;

    authMainBody = AuthMainBody(
      onConnexionPressed: (){
        setState(() {
          body = logInBody;
        });
      },
      onPlay: (){
        goToZoneSelection();

      },
    );

    logInBody.lastScreen = authMainBody;


    body = authMainBody;

  }


  @override
  Widget build(BuildContext context) {


    standardWidgets = StandardWidgets(context: context);



    Function? onBackButtonTapped = body.toString().compareTo("AuthMainBody") == 0 ? null : (){
      setState(() {
        blur = ImageFilter.blur(
          sigmaX: 0,
          sigmaY: 0,
        );
        body = body.lastScreen ?? body;
      });
    };


    Widget foreground = createForeground(onBackButtonTapped: onBackButtonTapped);

    Widget background = Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/main_background.png"),
            fit: BoxFit.cover
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
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