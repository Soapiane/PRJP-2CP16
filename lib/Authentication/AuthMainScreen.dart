

import 'package:flutter/material.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/TextStyles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import '../Color.dart' as color;

class AuthMainScreen extends StatelessWidget {


  late TextStyle buttonsTextStyle;


  AuthMainScreen({super.key});







  @override
  Widget build(BuildContext context) {



    ButtonGenerator buttonsGenerator = ButtonGenerator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);
    ImageGenerator imageGenerator = ImageGenerator(context: context);

    String userName = "Sofiane";


    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/main_background.png"),
                    fit: BoxFit.cover
                ),
              ),
            ),

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
            ),
            buttonsGenerator.generateTextButton(
              height: 45,
              width: 216,
              xPos: 472,
              yPos: 256,
              text: "Jouer",
              backgroundColor: color.Color.yellow,
            ),
            
            buttonsGenerator.generateTextButton(
              height: 44,
              width: 47,
              xPos: 733,
              yPos: 70,
              text: "FR",
              textColor: color.Color.brown,
              backgroundColor: color.Color.white,
              cornerRadius: 20,

            ),
            
            buttonsGenerator.generateImageButtom(
                height: 51,
                width: 51,
                xPos: 731,
                yPos: 9,
                borderRadius: BorderRadius.circular(23.5),
                imageProvider: const svg_provider.Svg("assets/settings.svg")
            ),

            textGenerator.generateText(
              xPos: 263,
              yPos: 327,
              text: "Connecté en tant que : $userName",
              fontSize: 16,
            ),

            



            
          ],
        ),
      ),
    );
  }

}