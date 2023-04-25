import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/ImageGenerator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/TextGenerator.dart';

class ScoreScreen extends StatelessWidget {

  void Function()? onRestart, onQuit;
  final String? title;
  final String scoreText, scoreAsset ;
  final int stars;
  late String? score;
  late Duration? time;

  ScoreScreen({Key? key, this.onRestart, this.onQuit, this.title = "Bravo !", required this.stars, this.time, this.score, this.scoreText = "Score", this.scoreAsset = "assets/hud/points.svg"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Generator generator = Generator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);


    String strDigits(int n) => n.toString().padLeft(2, '0');

    //global dims
    double xdim1 = generator.calculateX(300);
    double ydim1 = generator.calculateY(300);


    //child dims
    double xdim2 = generator.calculateX(222);
    double ydim2 = generator.calculateY(160);

    //info dims
    double xdim3 = generator.calculateX(222);
    double ydim3 = generator.calculateY(103);

    //buttons assets dims
    double xdim4 = generator.calculateX(19);
    double ydim4 = generator.calculateY(19);

    //buttons dims
    double xdim5 = (xdim2 - generator.calculateX(22))/2;
    double ydim5 = generator.calculateY(39);






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
              color: color.Color.yellowGreen.color,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,

              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset("assets/hud/score_screen/image.svg",
                        width: xdim1,
                      ),
                      SvgPicture.asset("assets/hud/score_screen/stars/${stars}_stars_score.svg",
                        width: generator.calculateX(222),
                        height: generator.calculateY(88),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: generator.calculateY(11)),
                  child: SizedBox(
                    width: xdim2,
                    height: ydim2,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: color.Color.yellowGreenDark.color,
                            ),
                            width: xdim3,
                            height: ydim3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 22, right: 22, top: 10),
                              child: Column(
                                children: [
                                  textGenerator.generateTextView(texts: [title!], fontSize: 16).first,
                                  time != null ? infoRow(context,"Temps:", "${strDigits(time!.inMinutes.remainder(60))}:${strDigits(time!.inSeconds.remainder(60))}", "assets/hud/time.svg") : const Visibility(visible: false, child: SizedBox.shrink()),
                                  score != null ? infoRow(context,"Score:", score!, scoreAsset) : const Visibility(visible: false, child: SizedBox.shrink()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton(
                              onPressed: onQuit,
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(10),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    color.Color.orange.color
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(xdim5, ydim5)
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/hud/score_screen/home.svg",
                                width: xdim4,
                                height: ydim4,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: onRestart,
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(10),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    color.Color.blue.color
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(xdim5, ydim5)
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/hud/score_screen/restart.svg",
                                width: xdim4,
                                height: ydim4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding infoRow(BuildContext context, String title, String value, String asset) {

    Generator generator = Generator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);

    double assetDimx = generator.calculateX(17);
    double assetDimy = generator.calculateY(17);

    double textSize = 13;


    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                asset,
                width: assetDimx,
                height: assetDimy,
              ),
              SizedBox(width: generator.calculateX(10)),
              textGenerator.generateTextView(texts: [title], fontSize: textSize).first,
            ],
          ),
          Row(
            children: [
              textGenerator.generateTextView(texts: [value],  fontSize: textSize).first,
              SizedBox(width: generator.calculateX(10)),
              SvgPicture.asset(
                asset,
                width: assetDimx,
                height: assetDimy,
              ),
            ],
          )
        ],
      ),
    );
  }

}
