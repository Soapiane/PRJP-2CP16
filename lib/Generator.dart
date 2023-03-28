import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class Generator {



  BuildContext context;
  late double deviceWidth, deviceHeight;



  Generator({required this.context}){
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;


  }




  Size calculateDimensions(double height, double width){


    double buttonWidth = deviceWidth*width/800;
    double buttonHeight = deviceHeight*height/360;

    return Size(buttonWidth, buttonHeight);
  }


  Vector2 calculateCoordinates(double xPos, double yPos){


    double x = deviceWidth*xPos/800;
    double y = deviceHeight*yPos/360;


    return Vector2(x, y);
  }

}

