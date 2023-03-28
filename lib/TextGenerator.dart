import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:projet2cp/Generator.dart';
import 'Color.dart' as color;

class TextGenerator extends Generator {
  TextGenerator({required super.context});

  Positioned generateText({
    required double xPos,
    required double yPos,
    required String text,
    double fontSize = 20,
    color.Color color = color.Color.white,
  }){


    Vector2 coords = calculateCoordinates(xPos, yPos);
    double x = coords.x;
    double y = coords.y;

    return Positioned(
      left: x,
      top: y,
      child: Text(text,
        style: TextStyle(
          color: color.color,
          fontFamily: 'PoppinsBold',
          fontSize: fontSize,
        ),
      ),
    );
  }

}