
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/Generator.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

class ImageGenerator extends Generator{


  ImageGenerator({required super.context});


  Widget generateImage({
    required double height,
    required double width,
    double? xPos,
    double? yPos,
    required String imagePath,
  }){

    Widget image;

    Vector2 dims = calculateXY(width, height);


    List<String> splattedPath = imagePath.split('.');
    if (splattedPath.last.compareTo("svg") == 0){

      image = SvgPicture.asset(imagePath,
        height: dims.y,
        width: dims.x,
      );
    } else {
      image = Image.asset(imagePath,
        height: dims.y,
        width: dims.x,
      );
    }

    if (xPos != null || yPos != null){


      Vector2 coords = calculateXY(xPos, yPos);



      return Positioned(
        left: coords.x,
        top:  coords.y,
        child: image,
      );
    }

    return image;



  }

}