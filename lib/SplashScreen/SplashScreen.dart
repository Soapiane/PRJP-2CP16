
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_levels_scrolling_map/widgets/loading_progress.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet2cp/Authentication/MainScreen.dart';
import 'package:projet2cp/Navigation/DefiState.dart';
import 'package:projet2cp/Navigation/Defis.dart';
import 'package:projet2cp/Navigation/Notifications/ChallengeNotification.dart';
import 'package:projet2cp/Navigation/Trophies.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projet2cp/Color.dart' as color;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();

}

class _SplashState extends State<SplashScreen>{



  @override
  void initState(){
    super.initState();


    navigateToHome();
  }

  navigateToHome()async{



    await DatabaseRepository().openDB();

    await DatabaseRepository().sync();









    await Future.delayed(Duration(milliseconds: 2000),(){



      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context)=> MainScreen(signedIn: FirebaseAuth.instance.currentUser != null)
          )
      );




    });
  }


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    double logoWidth = screenWidth/2.8 ;
    double logoHeight = 61.6522*logoWidth/82.5293;

    double loadingDim = screenWidth/11;


    return Scaffold(
      backgroundColor: color.Color.yellowGreenLigh.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   "assets/logo.svg",
            //   width: logoWidth,
            //   height: logoHeight,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 50,),
              child: LoadingAnimationWidget.hexagonDots(
                color: Colors.white,
                size: loadingDim,
              ),
            ),
          ],
        ),
      ),
    );
  }
}