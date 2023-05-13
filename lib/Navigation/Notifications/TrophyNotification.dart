import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Navigation/Trophies.dart';
import 'package:projet2cp/TextGenerator.dart';

class TrophyNotification extends StatelessWidget {

  String title;

  TrophyNotification({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Generator generator = Generator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);


    double xdim1 = generator.calculateX(349);
    double ydim1 = generator.calculateY(216);

    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Center(
        child: SizedBox(
          width: xdim1,
          height: ydim1,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color.Color.goldenYellow.color,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: generator.calculateY(20)),
                          child: textGenerator.generateTextView(
                            texts: ["Nouveau trophée débloqué !"],
                            fontSize: generator.calculateX(18),
                          ).first,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: generator.calculateX(27), right: generator.calculateX(27), bottom: generator.calculateY(10)),
                          child: const Divider(
                            color: Colors.white,
                            height: 15,
                            thickness: 1,
                          ),
                        ),
                        TropheNonObtenu( Trophe: title,),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: generator.calculateY(18)),
                      child: textGenerator.generateTextView(
                        texts: ["Appuyer pour continuer"],
                        fontSize: generator.calculateX(14),
                      ).first,
                    )
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}


class _TrophyShow extends StatelessWidget {
  String title;
   _TrophyShow({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Generator generator = Generator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);


    double xdim1 = generator.calculateX(295);
    double ydim1 = generator.calculateY(53);

    return Center(
        child: SizedBox(
          width: xdim1,
          height: ydim1,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color.Color.goldenYellowDark.color,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: generator.calculateX(10)),
                    child: SvgPicture.asset("assets/trophies/trophy.svg", width: generator.calculateX(30), height: generator.calculateY(30),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: generator.calculateX(22)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: generator.calculateX(12),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "AndikaNewBasicBold",
                              ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

