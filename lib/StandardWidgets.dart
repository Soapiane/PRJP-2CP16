
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Language.dart';

class StandardWidgets {
  BuildContext context;
  late ButtonGenerator buttonGenerator;
  double dim = 47;

  StandardWidgets({required this.context}){
    buttonGenerator = ButtonGenerator(context: context);
  }

  Widget settingsButton(){
    return buttonGenerator.generateImageButtom(
      height: dim,
      width: dim,
      xPos: 731,
      yPos: 9,
      borderRadius: BorderRadius.circular(23.5),
      imagePath: "assets/settings.svg",
    );
  }

  Widget languageButton(Language language ){
    return buttonGenerator.generateTextButton(
      height: dim,
      width: dim,
      xPos: 733,
      yPos: 70,
      text: language.code,
      textColor: color.Color.brown,
      backgroundColor: color.Color.white,
      cornerRadius: 23,

    ).first;
  }

  Widget backButton({Function? onBackButtonTapped}){
    return buttonGenerator.generateImageButtom(
      height: 51,
      width: 51,
      xPos: 12,
      yPos: 15,
      imagePath: "assets/back.svg",
      borderRadius: BorderRadius.circular(13),
      onTap: (){
        onBackButtonTapped?.call();
      }
    );
  }


}