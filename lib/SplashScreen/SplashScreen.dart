import 'dart:io';

import 'package:flutter/material.dart';
import '../MainScreen/MainScreen.dart';
import 'package:flutter/src/widgets/image.dart';
import 'dart:ui' as ui;


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
    await Future.delayed(Duration(milliseconds: 2000),(){

    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context)=> MyHomePage(
              title: "Flutter Demo",
            )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'Splash Screen',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}