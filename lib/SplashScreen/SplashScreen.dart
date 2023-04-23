
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/MainScreen.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:sqflite/sqflite.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.order = 0}) : super(key: key);

  final int order;

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

    await DatabaseRepository().database!.update("level", {
      "stars": 2,
      },
      where: "id = ?",
      whereArgs: [17],

    );

    await DatabaseRepository().printDB();


    if (FirebaseAuth.instance.currentUser != null) {
      await DatabaseRepository().syncZone(Zones.foret);
    }


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
    String text = 'Splash Screen ' + widget.order.toString();
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}