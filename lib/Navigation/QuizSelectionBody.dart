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




class QuizSelectionBody extends Body {

  /// same as [ZoneSelectionBody], but dedicated for the the quizzes, so the info that are visible are
  /// image of the zone, stars of the quiz, and the locked quiz view


  Function(bool unlocked, Zones zone, int order) onCardTap;
  List<Map> quizzesInfo = [];


  QuizSelectionBody({super.key, required this.quizzesInfo ,required this.onCardTap, super.isBlured = true}){
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
          return index != Zones.values.length ? ZoneCard(
            isLocked: quizzesInfo[index]["isLocked"] == 1 ? true : false,
            collectedStars: quizzesInfo[index]["stars"],
            zone: Zones.values[index],
            onTap: onCardTap,
          ) : Visibility(child: SizedBox(width: seperation,), visible: false,);
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: seperation,);
        },
        itemCount: Zones.values.length + 1,
      ),
    );
  }




}


class ZoneCard extends StatelessWidget {

  int collectedStars;
  bool isLocked;
  Zones zone;
  Function(bool unlocked, Zones zone, int order) onTap;
  ZoneCard({Key? key,required this.isLocked, required this.collectedStars, required this.zone, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    TextGenerator textGenerator = TextGenerator(context: context);

    double cardWidth = textGenerator.calculateX(164);
    double cardHeight = textGenerator.calculateY(215);

    return GestureDetector(
      onTap: (){
        onTap(!isLocked ,zone, 4);
      },
      child: Center(
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
                          child: !isLocked ? Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/zones/star.svg",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  "$collectedStars/3",
                                  style: TextStyle(
                                    color: color.Color.blackOlive.color,
                                    fontSize: 14,
                                    fontFamily: "AndikaNewBasic",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ) : SizedBox.shrink(),
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
                ),
                isLocked ? Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ) : SizedBox.shrink(),
                isLocked ? Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/zones/cards/lock.svg",
                        width: textGenerator.calculateX(50),
                        height: textGenerator.calculateY(50),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: textGenerator.calculateY(30)),
                        child: Text(
                          "Débloquer en mode aventure",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: textGenerator.calculateX(14),
                            fontFamily: "AndikaNewBasicBold",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ) : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

