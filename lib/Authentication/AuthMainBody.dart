

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Body.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Guest.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/Color.dart' as color;

class AuthMainBody extends Body {

  Function onConnexionPressed, onPlay;

  AuthMainBody({super.key, required this.onConnexionPressed, required this.onPlay});


  @override
  Widget build(BuildContext context) {


    ButtonGenerator buttonsGenerator = ButtonGenerator(context: context);
    ImageGenerator imageGenerator = ImageGenerator(context: context);


    return Stack(
      children: [
        imageGenerator.generateImage(
          height: 153,
          width: 173,
          xPos: 317,
          yPos: 133,
          imagePath: "assets/tree_planting.svg",
        ),

        buttonsGenerator.generateTextButton(
            height: 45,
            width: 216,
            xPos: 97,
            yPos: 256,
            text: "Se Connecter",
            backgroundColor: color.Color.blue,
            onTap: (){
              onConnexionPressed.call();
            },
        ).first,
        buttonsGenerator.generateTextButton(
          height: 45,
          width: 216,
          xPos: 472,
          yPos: 256,
          text: "Jouer",
          backgroundColor: color.Color.yellow,
          onTap: (){
            onPlayPressed();
          },
        ).first,

      ],
    );
  }

  Future<void> onPlayPressed() async {
    GuestRepository().openDB();
    onPlay.call();
  }






}