import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/Navigation/Zone/ZoneBody.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:projet2cp/Navigation/Zones.dart';

class ZoneSelectionBody extends Body {

  Function(Zones zone) onCardTap;

  ZoneSelectionBody({super.key, required this.onCardTap, super.isBlured = true});

  Future<void> testQuery() async {
    await DatabaseRepository().printDB();
    var result = (await DatabaseRepository().database!.rawQuery("SELECT * FROM level WHERE zone_id = ? ORDER BY level ASC", [3])).toList();
    print("and value is: $result");
  }

  @override
  Widget build(BuildContext context) {
    
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);

    double seperation = buttonGenerator.calculateX(65);




    if (FirebaseAuth.instance.currentUser != null){
      testQuery();


    }


    
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
                  onTap: (){
                    onCardTap.call(Zones.values[index]);
                  },
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