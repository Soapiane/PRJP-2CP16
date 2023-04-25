import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/TextGenerator.dart';

class Warning extends StatelessWidget {

  final String text;
  Function() onOk;

   Warning({Key? key, this.text = "mode de passe incorrect", required this.onOk}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ImageGenerator imageGenerator = ImageGenerator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);


    SvgPicture warning = SvgPicture.asset("assets/nav_buttons/warning.svg", width: imageGenerator.calculateY(15), height: imageGenerator.calculateY(15),);

    //dimensions
    double xdim1 = imageGenerator.calculateX(283);
    double ydim1 = imageGenerator.calculateY(150);

    double borderRadius = 20;

    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: xdim1,
              height: ydim1,
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: color.Color.terraCottaRed.color,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(left: imageGenerator.calculateX(16),right: imageGenerator.calculateX(16), top: imageGenerator.calculateY(13)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  warning,
                                  textGenerator.generateTextView(texts: ["Oups..."], fontSize: 11).first,
                                  warning,
                                ],
                              ),
                              const Divider(
                                color: Colors.white,
                                height: 15,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: textGenerator.generateTextView(texts: [text], fontSize: 11).first,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: imageGenerator.calculateY(10)),
                          child: ElevatedButton(
                            onPressed: onOk,
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(10),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(borderRadius),
                                  )
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  color.Color.terraCottaRedDark.color
                              ),
                            ),
                            child: textGenerator.generateTextView(texts: ["d'accord"], fontSize: 11).first,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: imageGenerator.calculateX(550),
            top: imageGenerator.calculateY(167),
            child: SvgPicture.asset("assets/terra/earth_surprised.svg"),
          ),
        ],
      ),
    );
  }
}
