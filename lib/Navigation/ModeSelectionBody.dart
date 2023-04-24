import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/MiniGames/Hud/ScoreScreen.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/Navigation/Mode.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/TextGenerator.dart';

class ModeSelectionBody extends Body {

  final Function(Mode)? onModeSelected;


  ModeSelectionBody({Key? key, this.onModeSelected, super.lastScreen}) : super(key: key);

  Future<void> testMenu(BuildContext context) async {

    Widget menu = ScoreScreen(stars: 1,).build(context);

    await Future.delayed(const Duration(milliseconds: 2000),(){


      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return ScoreScreen(stars: 1,);
        },
      );

    });
  }


  @override
  Widget build(BuildContext context) {

    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);
    TextGenerator textGenerator = TextGenerator(context: context);

    testMenu(context);






    return
      MaterialApp(
        theme: ThemeData().copyWith(
      colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green),
      ),
      home: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: [
              textGenerator.generateTextView(
                texts: ["Choisissez le mode de jeu"],
                fontSize: 20,
                color: color.Color.blackOlive,
              ).first,
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 150),
                      child: buttonGenerator.generateImageButtom(
                        width: 120,
                        height: 143,
                        imagePath: "assets/modes/quiz_mode.svg",
                        backgroundColor: color.Color.denimBlue,
                        borderRadius: BorderRadius.circular(15),
                        paddingVertical: 10,
                        paddingHorizontal: 75,
                        onTap: (){
                          onModeSelected?.call(Mode.quiz);
                        },
                      ),
                    ),
                    buttonGenerator.generateImageButtom(
                      width: 120,
                      height: 143,
                      imagePath: "assets/modes/adventure_mode.svg",
                      backgroundColor: color.Color.yellow,
                      borderRadius: BorderRadius.circular(15),
                      paddingVertical: 10,
                      paddingHorizontal: 75,
                      onTap: (){
                        onModeSelected?.call(Mode.adventure);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),
      ),
      );
  }

}


class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
