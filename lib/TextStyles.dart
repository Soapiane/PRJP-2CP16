

import 'package:flutter/material.dart';
import 'Color.dart' as color;

class TextStyles {


  //a class that contains the text style used in most of the app

  static TextStyle buttonsTextStyle({
    color.Color color = color.Color.white,
    double fontSize = 21,
  }){
    return TextStyle(

        color: color.color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'AndikaNewBasic'
    );
  }

}