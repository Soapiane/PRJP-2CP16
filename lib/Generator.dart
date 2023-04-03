import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class Generator {



  BuildContext context;
  late double deviceWidth, deviceHeight;



  Generator({required this.context}){
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;


  }


  double calculateX(double? x){
    return deviceWidth*(x??=0)/800;
  }

  double calculateY(double? y){
    return deviceHeight*(y??=0)/360;
  }




  Vector2 calculateXY(double? x, double? y){


    double xRelative = calculateX(x);
    double yRelative = calculateY(y);


    return Vector2(xRelative, yRelative);
  }





}

