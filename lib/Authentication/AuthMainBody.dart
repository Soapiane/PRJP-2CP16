

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Info/Guest.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Navigation/Loading.dart';
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
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding:  EdgeInsets.only(top: imageGenerator.calculateY(8)),
            child: SvgPicture.asset(
              "assets/logo.svg",
              width: imageGenerator.calculateX(197),
              height: imageGenerator.calculateY(147),
            ),
          ),
        ),
        imageGenerator.generateImage(
          height: 127,
          width: 144,
          xPos: 328,
          yPos: 165,
          imagePath: "assets/terra/earth_planting.svg",
        ),

        buttonsGenerator.generateTextButton(
            height: 45,
            width: 216,
            xPos: 97,
            yPos: 256,
            text: "Se connecter",
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
            onPlayPressed(context);
          },
        ).first,

      ],
    );
  }

  Future<void> onPlayPressed(BuildContext context) async {
    Loading.ShowLoading(context);
    //opens the guest dp
    await GuestRepository().openDB();
    Loading.HideLoading(context);
    onPlay.call();
  }






}