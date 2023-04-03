import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/Body.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Zones.dart';

class ZoneSelectionBody extends Body {

  ZoneSelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);

    double seperation = buttonGenerator.calculateX(65);
    
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: buttonGenerator.calculateY(215),
            child: ListView.separated(
              padding: EdgeInsets.only(left: seperation),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return buttonGenerator.generateImageButtom(
                  height: 215,
                  width: 164,
                  imagePath: Zones.values[index].cardImagePath,
                  borderRadius: BorderRadius.circular(10),
                );
              },
              separatorBuilder: (context, index){
                return SizedBox(width: seperation,);
              },
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

}