

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/TextStyles.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

class ButtonGenerator extends Generator{




  ButtonGenerator({required super.context});




  Widget generateTextButton({
    required double height,
    required double width,
    double? xPos,
    double? yPos,
    String text= "",
    color.Color textColor = color.Color.white,
    double textSize = 21,
    color.Color backgroundColor = color.Color.transparent,
    double cornerRadius  = 50,
    Function? onTap,
    Margin? margin,
  }){





    Vector2 dims = calculateXY(width, height);
    double buttonWidth = dims.x;
    double buttonHeight = dims.y;

    margin??=Margin(context: context);

    Widget buttonWidget = Container(
      margin: EdgeInsets.fromLTRB(margin.left, margin.top, margin.right, margin.bottom),
      child: ElevatedButton(
        onPressed: (){
          onTap?.call();
        },
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
            fontSize: textSize,
          ),
        ),
      ),
    );


    if (xPos != null || yPos != null){


      Vector2 coords = calculateXY(xPos, yPos);



      return Positioned(
        left: coords.x,
        top:  coords.y,
        child: buttonWidget,
      );
    }

    return buttonWidget;



  }

  Widget generateImageButtom({
    required double height,
    required double width,
    double? xPos,
    double? yPos,
    required String imagePath,
    BorderRadius? borderRadius,
    Function? onTap,
    color.Color backgroundColor = color.Color.transparent,
    double elevation = 2,
    double paddingVertical = 0,
    double paddingHorizontal = 0,
  }){
    Vector2 dims = calculateXY(width, height);

    Widget image;
    List<String> splattedPath = imagePath.split('.');
    if (splattedPath.last.compareTo("svg") == 0){

       image = Ink.image(
        image: svg_provider.Svg(imagePath,
          size: Size(
            dims.x,
            dims.y,
          ),
        ),
        height: dims.y+paddingVertical,
        width: dims.x+paddingHorizontal,
      );
    } else {
      image = Image.asset(imagePath,
        height: dims.x,
        width: dims.y,
      );
    }


    Widget buttonWidget = Wrap(
      children: [Material(

        type: MaterialType.button,
        color: backgroundColor.color,
        elevation: elevation,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: (){
            onTap?.call();
          },
          borderRadius: borderRadius,
          child: image,

        ),
      )],
    );


    if (xPos != null || yPos != null){


      Vector2 coords = calculateXY(xPos, yPos);



      return Positioned(
        left: coords.x,
        top:  coords.y,
        child: buttonWidget,
      );
    }

    return buttonWidget;

  }


}