
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Info/Language.dart';

class StandardWidgets {
  BuildContext context;
  late ButtonGenerator buttonGenerator;
  double dim = 45;

  StandardWidgets({required this.context}){
    buttonGenerator = ButtonGenerator(context: context);
  }

  Widget settingsButton(Function onSettingsButtonTapped){
    return buttonGenerator.generateImageButtom(
      height: dim,
      width: dim,
      borderRadius: BorderRadius.circular(23.5),
      imagePath: "assets/nav_buttons/settings.svg",
      onTap: onSettingsButtonTapped,
    );
  }

  Widget languageButton(Language language ){
    return buttonGenerator.generateTextButton(
      height: dim,
      width: dim,
      text: language.code,
      textColor: color.Color.brown,
      backgroundColor: color.Color.white,
      cornerRadius: 23,
    ).first;
  }

  Widget backButton({Function? onBackButtonTapped}){
    return buttonGenerator.generateImageButtom(
      height: dim,
      width: dim,
      imagePath: "assets/nav_buttons/back.svg",
      borderRadius: BorderRadius.circular(13),
      onTap: (){
        onBackButtonTapped?.call();
      }
    );
  }

  Widget challengesButton({Function? onChallengesButtonTapped}){
    return buttonGenerator.generateImageButtom(
      height: dim,
      width: dim,
      imagePath: "assets/nav_buttons/challenges.svg",
      borderRadius: BorderRadius.circular(50),
      onTap: (){
        onChallengesButtonTapped?.call();
      }
    );
  }

  Widget trophiesButton({Function? onTrophiesButtonTapped}){
    return buttonGenerator.generateImageButtom(
      height: dim,
      width: dim,
      imagePath: "assets/nav_buttons/trophies.svg",
      borderRadius: BorderRadius.circular(50),
      onTap: (){
        onTrophiesButtonTapped?.call();
      }
    );
  }


}