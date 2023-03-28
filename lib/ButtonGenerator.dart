

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/TextStyles.dart';
import 'Color.dart' as color;

class ButtonGenerator extends Generator{




  ButtonGenerator({required super.context});




  Positioned generateTextButton({
    required double height,
    required double width,
    required double xPos,
    required double yPos,
    String text= "",
    color.Color textColor = color.Color.white,
    color.Color backgroundColor = color.Color.transparent,
    double cornerRadius  = 50,
  }){



    Size dims = calculateDimensions(height, width);
    double buttonWidth = dims.width;
    double buttonHeight = dims.height;



    Vector2 coords = calculateCoordinates(xPos, yPos);
    double x = coords.x;
    double y = coords.y;


    return Positioned(
        left: x,
        top: y,
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: backgroundColor.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            minimumSize: Size.zero,
            fixedSize: Size(
                buttonWidth,
                buttonHeight
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyles.buttonsTextStyle(
              color: textColor,
            ),
          ),
        ),
      );
  }

  Positioned generateImageButtom({
    required double height,
    required double width,
    required double xPos,
    required double yPos,
    required ImageProvider imageProvider,
    BorderRadius? borderRadius,
  }){

    Size dims = calculateDimensions(height, width);
    double buttonWidth = dims.width;
    double buttonHeight = dims.height;


    Vector2 coords = calculateCoordinates(xPos, yPos);
    double x = coords.x;
    double y = coords.y;

    return Positioned(
      left: x,
      top: y,
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: (){},
          child: Ink.image(
            image: imageProvider,
            height: buttonHeight,
            width: buttonWidth,
          ),
        ),
      ),
    );
  }


}