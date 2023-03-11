import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projet2cp/Zone/Zones.dart';
import '../Zone/ZoneMainScreen.dart';
import 'package:flutter/src/widgets/image.dart';
import 'dart:ui' as ui;


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
    await Future.delayed(Duration(milliseconds: 2000),(){

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context)=> const ZoneMainScreen(zone: Zones.ville)
          )
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    String text = 'Splash Screen ' + widget.order!.toString();
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