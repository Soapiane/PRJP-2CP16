import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Body.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Color.dart';
import 'package:projet2cp/Difficulty.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/Triple.dart';
import 'package:projet2cp/User.dart';


class DifficultySelectionBody extends Body {

  Function? onContinue;

  DifficultySelectionBody({required this.onContinue, super.key});

  @override
  Widget build(BuildContext context) {
    return _DifficultySelectionBody(onContinue: onContinue);
  }

}




class _DifficultySelectionBody extends StatefulWidget {

  Function? onContinue;


  _DifficultySelectionBody({required this.onContinue, super.key});

  @override
  State<StatefulWidget> createState() {
    return _DifficultySelectionBodyState();
  }
}

class _DifficultySelectionBodyState extends State<_DifficultySelectionBody> {
  late List<Triple> buttons;
  late int selected = 0;
  late ButtonGenerator buttonGenerator;
  late TextGenerator textGenerator;

  @override
  void initState() {
    super.initState();

  }

  void setAllButtonsToWhite(){
    for (Triple element in buttons) {
      element.second.backgroundColor = color.Color.white;
      element.third.textColor = color.Color.blackOlive;
    }
  }


  @override
  Widget build(BuildContext context) {


    buttons = [];
    buttonGenerator = ButtonGenerator(context: context);
    textGenerator = TextGenerator(context: context);

    for (Difficulty difficulty in Difficulty.values) {
      buttons.add(buttonGenerator.generateTextButton(
          height: 50,
          width: 250,
          margin: Margin(
            top: difficulty.index == 0 ? 20 : 0,
            bottom: 7,
            context: context,
          ),
          text: difficulty.name,
          textSize: 16,
          backgroundColor: selected == difficulty.index ? color.Color.bangladeshGreen : color.Color.white,
          textColor: selected == difficulty.index ? color.Color.white : color.Color.blackOlive,
          onTap: (){
            setState(() {
              selected = difficulty.index;
            });
          },
        )
      );
    }
    
    
    
    
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green),
      ),
      home: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              textGenerator.generateTextView(
                texts: ["Entrez l’age de l’enfant"],
                color: color.Color.blackOlive,
                fontSize: 16,
              ).first,
              buttons[Difficulty.EASY.index].first,
              buttons[Difficulty.MEDIUM.index].first,
              buttons[Difficulty.HARD.index].first,
              buttonGenerator.generateTextButton(
                height: 45,
                width: 250,
                text: "Continuer",
                margin: Margin(
                  top: 15,
                  context: context,
                ),
                backgroundColor: color.Color.yellow,
                textColor: color.Color.white,
                onTap: (){
                  _onContinue();
                },
              ).first,
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _onContinue() async {

    User().setDifficulty(Difficulty.values[selected]);
    DatabaseRepository().uploadUserInfo();
    widget.onContinue?.call();
  }
  
}