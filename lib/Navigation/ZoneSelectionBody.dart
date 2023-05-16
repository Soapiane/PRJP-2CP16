import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/Navigation/Loading.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/TextStyles.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:sqflite/sqflite.dart';

class ZoneSelectionBody extends Body {

  //this class creates a list of cards, each card represents a zone and contains basic info (stars collected, name, picture...etc)


  Function(Zones zone) onCardTap;
  List<int> starsCollected = [], starsMax = [];


  ZoneSelectionBody({super.key, required this.starsCollected, required this.starsMax ,required this.onCardTap, super.isBlured = true}){
  }




  @override
  Widget build(BuildContext context) {

    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);

    double seperation = buttonGenerator.calculateX(65);


    return Center(
      child: ListView.separated(
        padding: EdgeInsets.only(left: seperation),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onCardTap(Zones.values[index]);
            },
            child: index != Zones.values.length-1 ? ZoneCard(
              collectedStars: starsCollected[index],
              maxStars: starsMax[index],
              zone: Zones.values[index],
            ) : Visibility(child: SizedBox(width: seperation,), visible: false,),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: seperation,);
        },
        itemCount: Zones.values.length,
      ),
    );
  }




}


class ZoneCard extends StatelessWidget {

  //view of the zone card

  int collectedStars, maxStars;
  Zones zone;
  ZoneCard({Key? key, required this.collectedStars, required this.maxStars, required this.zone}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Generator generator = Generator(context: context);

    double cardWidth = generator.calculateX(164);
    double cardHeight = generator.calculateY(215);

    return Center(
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 10,
          child: Stack(
            children:  [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image(
                  height: cardHeight,
                  width: cardWidth,
                  fit: BoxFit.cover,
                  image: AssetImage(
                    zone.cardImagePath,

                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xffE28D4D),
                            Colors.transparent,
                          ],
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/zones/star.svg",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: Text(
                                "$collectedStars/$maxStars",
                                style: TextStyle(
                                  color: color.Color.blackOlive.color,
                                  fontSize: 14,
                                  fontFamily: "AndikaNewBasic",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        color: Color(0xffE28D4D),

                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Text(
                              zone.name,
                              style: TextStyle(
                                color: color.Color.blackOlive.color,
                                fontSize: 14,
                                fontFamily: "AndikaNewBasic",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

