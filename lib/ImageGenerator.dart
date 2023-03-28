
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/Generator.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

class ImageGenerator extends Generator{

  late Widget image;

  ImageGenerator({required super.context});


  Positioned generateImage({
    required double height,
    required double width,
    required double xPos,
    required double yPos,
    required String imagePath,
  }){

    Size dims = calculateDimensions(height, width);
    double imageWidth = dims.width;
    double imageHeight = dims.height;

    Vector2 coords = calculateCoordinates(xPos, yPos);
    double x = coords.x;
    double y = coords.y;




    List<String> splattedPath = imagePath.split('.');
    if (splattedPath.last.compareTo("svg") == 0){

      image = SvgPicture.asset(imagePath,
        height: imageHeight,
        width: imageWidth,
      );
    } else {
      image = Image.asset(imagePath,
        height: imageHeight,
        width: imageWidth,
      );
    }


    return Positioned(
      left: x,
      top: y,
      child: image,
    );


  }

}