import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/TextGenerator.dart';


class TutoScreen extends StatelessWidget {

  late String? path;

  TutoScreen({Key? key,  this.path }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    path ??=  "assets/tutorials/turning_pipes.png";
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);
    
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            path!,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(buttonGenerator.calculateX(20)),
            child: buttonGenerator.generateImageButtom(
              height: 45,
              width: 45,
              imagePath: "assets/nav_buttons/continue.svg",
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}