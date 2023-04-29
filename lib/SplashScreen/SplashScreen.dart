
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/MainScreen.dart';
import 'package:projet2cp/Navigation/DefiState.dart';
import 'package:projet2cp/Navigation/Defis.dart';
import 'package:projet2cp/Navigation/Trophies.dart';
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

    const String databaseLink = "https://projet2cp-1c628-default-rtdb.europe-west1.firebasedatabase.app/";

    // await FirebaseAuth.instance.signOut();
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