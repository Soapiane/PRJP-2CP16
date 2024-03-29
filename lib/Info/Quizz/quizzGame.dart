import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projet2cp/MiniGames/MiniGame.dart';
import 'package:projet2cp/MiniGames/Quizz/Quizz.dart';
import 'package:projet2cp/MiniGames/Quizz/data/foret_questions.dart';
import 'package:projet2cp/MiniGames/Quizz/data/ville_questions.dart';
import 'package:projet2cp/MiniGames/Quizz/data/zone_questions.dart';
import 'package:projet2cp/MiniGames/Quizz/model/question_model.dart';
import 'package:projet2cp/MiniGames/Quizz/screens/pop_up.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/MiniGames/Quizz/data/mer_questions.dart';
import 'package:projet2cp/MiniGames/Quizz/data/random_quizz.dart';

//write comments for this class

//This class is the main class of the game Quizz that gets the game zone and the game reference and the questions of the game
class QuizzGame extends StatefulWidget {
  final Zones zone;
  final Quizz? gameRef;
  List<QuestionModel> questions = [];
  QuizzGame({super.key, required this.zone, this.gameRef}) {
    //the questions are chosen according to the zone, they are stored in the data file
    switch (zone) {
      case Zones.mer:
        {
          questions = questionsMer;
        }
        break;
      case Zones.foret:
        {
          questions = questionsForet;
        }
        break;
      case Zones.ville:
        {
          questions = questionsVille;
        }
        break;
      case Zones.zoneIndustrielle:
        {
          questions = questionsZone;
        }
        break;
      case Zones.alea:
        {
          questions = questionsRandom;
        }
    }
  }

  @override
  State<QuizzGame> createState() => _QuizzGameState();
}

class _QuizzGameState extends State<QuizzGame> {
  GlobalKey<_QuizzGameState> homePageKey = GlobalKey<_QuizzGameState>();
  late int rounds = 0;
  Color secondColor = Color.fromRGBO(81, 140, 250, 1);
  final PageController _controller = PageController(
      initialPage: 0); //page controller to navigate between the questions
  bool isPressed = false;
  Color trueAnswer = Color.fromARGB(255, 113, 173, 56);
  bool _buttonVisible = false;
  Color falseAnswer = Color.fromARGB(255, 254, 48, 48);

  int score = 0;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayerExplanation = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.gameRef!.hud.onExit = () {
      audioPlayer.stop();
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: QuizzPage(widget.zone.backgroundImagePath, widget.questions),
    );
  }

  Stack QuizzPage(String backGroundPath, List<QuestionModel> questions) {
    //This is the main page of the game where the questions are displayed and the answers are checked and the score is calculated
    if (widget.gameRef != null) {
      widget.gameRef!.addPoints(maxPoints: questions.length);
    }
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
        ),
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: PageView.builder(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                isPressed = false;
              });
            },
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.05,
                      width: width * 0.05,
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: secondColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            //this is used to count questions in list
                            '${index + 1}/${questions.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'AndikaNewBasic',
                              fontSize: 11.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.8,
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: secondColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            //get the current question
                            questions[index].question!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'AndikaNewBasic',
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      onTap: () {
                        audioPlayer.play(AssetSource(
                            'audios/${questions[index].audioPlayer!}'));
                      },
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      width: width * 0.8,
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        //thiis index conditions are used to check if the question has 2 or 4 answers (two or four option buttons)
                        children: [
                          for (int j = 0;
                              j <
                                  (rounds =
                                      ((questions[index].answers!.length) == 2)
                                          ? 1
                                          : 2);
                              j++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: height * 0.25,
                                ),
                                for (int i = 0; i < 2; i++)
                                  Center(
                                    child: SizedBox(
                                      width: (width * 0.8 / 2) - 50,
                                      height: height * 0.2,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        elevation: 0.2,
                                        color: isPressed
                                            ? questions[index]
                                                    .answers!
                                                    .entries
                                                    .toList()[(j == 1 &&
                                                            questions[index]
                                                                    .answers!
                                                                    .length ==
                                                                4)
                                                        ? i + j + 1
                                                        : i + j]
                                                    .value
                                                ? trueAnswer
                                                : falseAnswer
                                            : secondColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 4.0),
                                        onPressed: isPressed
                                            ? () {}
                                            : () {
                                                setState(() {
                                                  isPressed = true;
                                                });
                                                //after the option button is pressed
                                                _buttonVisible =
                                                    true; //this makes the suivant/resultat button visible
                                                audioPlayer.stop();
                                                audioPlayer.release();

                                                if (questions[index]
                                                    .answers!
                                                    .entries
                                                    .toList()[(j == 1 &&
                                                            questions[index]
                                                                    .answers!
                                                                    .length ==
                                                                4)
                                                        ? i + j + 1
                                                        : i + j]
                                                    .value) {
                                                  //here value is set to true
                                                  score += 1;
                                                  if (widget.gameRef != null) {
                                                    //the score is modified
                                                    widget.gameRef!
                                                        .modifyPoints(
                                                            points: 1);
                                                  }
                                                  if (questions[index]
                                                          .explanation !=
                                                      null) {
                                                    //if the answer is correct and there is an explanation
                                                    audioPlayerExplanation.play(
                                                        AssetSource(
                                                            'audios/${questions[index].audioPalyerExplanation!}'));
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Stack(
                                                          children: [
                                                            BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX: 2,
                                                                      sigmaY:
                                                                          2),
                                                              child: Container(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                            //the pop up screen for the explanation of the question if there is one
                                                            PopUpScreen(
                                                              questions[index]
                                                                  .explanation!,
                                                              true,
                                                              audioPlayerExplanation,
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                } else {
                                                  //if the answer is wrong
                                                  if (questions[index]
                                                          .explanation !=
                                                      null) {
                                                    audioPlayerExplanation.play(
                                                        AssetSource(
                                                            'audios/${questions[index].audioPalyerExplanation!}'));
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Stack(
                                                          children: [
                                                            BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX: 2,
                                                                      sigmaY:
                                                                          2),
                                                              child: Container(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                            PopUpScreen(
                                                              questions[index]
                                                                  .explanation!,
                                                              false,
                                                              audioPlayerExplanation,
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                }
                                              },
                                        child: Text(
                                          //get the option's text
                                          questions[index]
                                              .answers!
                                              .keys
                                              .toList()[(j == 1 &&
                                                  questions[index]
                                                          .answers!
                                                          .length ==
                                                      4)
                                              ? i + j + 1
                                              : i + j],
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 243, 236, 236),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'AndikaNewBasic',
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Opacity(
                          opacity: _buttonVisible ? 1.0 : 0.0,
                          //this button allows the user to go to the next question or to see the result if it is the last question after answering the current question
                          child: OutlinedButton(
                            onPressed: isPressed
                                ? index + 1 == questions.length
                                    ? () {
                                        audioPlayer.stop();
                                        audioPlayer.release();
                                        audioPlayerExplanation.stop();
                                        audioPlayerExplanation.release();

                                        if (widget.gameRef != null) {
                                          widget.gameRef!.onFinished();
                                        }
                                      }
                                    : () {
                                        _controller!.nextPage(
                                            duration:
                                                Duration(microseconds: 500),
                                            curve: Curves.linear);
                                        _buttonVisible = false;
                                      }
                                : null,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: secondColor,
                              shape: StadiumBorder(),
                              shadowColor: Colors.grey.withOpacity(0.5),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                //if it is the last question, the button will show "Voir le résultat" else it will show "Suivant"
                                index + 1 == questions.length
                                    ? "Voir le résultat"
                                    : "Suivant",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'AndikaNewBasic',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            child: SvgPicture.asset(
              'assets/images/Quizz/earth/earth.svg',
              fit: BoxFit.cover,
              width: 60,
            ),
          ),
        ),
      ],
    );
  }
}
