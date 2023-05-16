import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

//this class is used to display a pop up screen when the user answers a question and there is an explanation of the answer
class PopUpScreen extends StatelessWidget {
  final String? message;
  final bool isCorrect;
  final AudioPlayer audioPlayer;

  PopUpScreen(this.message, this.isCorrect, this.audioPlayer);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            audioPlayer.stop();
            audioPlayer.release();
            Navigator.of(context).pop();
          },
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: width,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                backgroundColor: (isCorrect)
                    ? Color.fromARGB(255, 113, 173,
                        56) //the screen is green if the answer is right
                    : Color.fromARGB(255, 254, 48,
                        48), //ths screen is red if the answer is wrong
                titlePadding: const EdgeInsets.all(5.0),
                title: Text(
                  (isCorrect)
                      ? 'Bravo!'
                      : 'Oupss!', //based on the answer being correct or false
                  style: const TextStyle(
                      color: Color.fromARGB(255, 244, 244, 244),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AndikaNewBasic',
                      fontSize: 15.0,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2.0),
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width * 0.6,
                          child: Text(
                            message!,
                            style: TextStyle(
                              //here the explanation is displayed
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'AndikaNewBasic',
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Image.asset(
                          //the image being a sick earth and a love spreading one based on the answer being corect or false
                          (isCorrect)
                              ? 'assets/images/Quizz/earth/spreading_love.png'
                              : 'assets/images/Quizz/earth/medecine.png',
                          width: (isCorrect) ? width * 0.15 : width * 0.15,
                        ),
                      ],
                    ),
                    const Text(
                      //go back to the questions
                      "Appuyez pour continuer",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AndikaNewBasic',
                          fontSize: 11.0),
                    )
                  ],
                ),
              ),
            ),
          ),
        )

        // Popup content
      ],
    );
  }
}
