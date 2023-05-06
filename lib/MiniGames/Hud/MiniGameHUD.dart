


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/MiniGames/Hud/PauseScreen.dart';
import 'package:projet2cp/MiniGames/Hud/ProgressBar.dart';
import 'package:projet2cp/MiniGames/Hud/ScoreScreen.dart';
import 'package:projet2cp/Navigation/Loading.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/StandardWidgets.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Info/User.dart' as user;
import 'package:projet2cp/Info/Guest.dart' as guest;

class MiniGameHUD extends StatefulWidget{

  Zones zone;
  int? countdown;
  int? maxPoints;
  int initialPoints, initialStars;
  String pointsAsset, pointsText;
  late _MiniGameHUDState state;
  Function? onGameTimeOut, onGamePaused, resumeGame, restartGame, onMaxPointsReached;
  Function(int)?  onStarsModified;
  Function(int, int)? onPointsModified;
  Function(Duration)? onTimeUpdate;
  Color? textColor;
  bool visible, hideBackground;
  bool useBar;





  MiniGameHUD({super.key, required this.zone, this.countdown, this.maxPoints, this.pointsAsset = "assets/hud/points.svg", this.pointsText = "Score", this.initialPoints = 0, this.initialStars = 0,
    this.textColor, this.visible = true, this.hideBackground = false, this.useBar = false}){
    textColor = Colors.white;

    state = _MiniGameHUDState();
  }

  int getStars(){
    return state.stars;
  }

  int getPoints(){
    return state.points;
  }

  Duration? getTimer(){
    return state.timerDuration;
  }




  void onMaxPoints(){
    state.onMaxPointsReached();
  }

  void onFinished(){
    state.onFinished();
  }


  void modifyPoints({required int points}){
    state.modifyPoints(points: points);
  }

  void setStars({required int stars}){
    state.setStars(stars);
  }


  BuildContext getHudContext(){
    return state.context;
  }



  @override
  State<StatefulWidget> createState() {
    return state;
}


}


class _MiniGameHUDState extends State<MiniGameHUD>{



  Timer? countdownTimer;
  late Duration timerDuration;
  late String seconds = "0", minutes = "0";
  int points = 0, stars = 0;
  late bool hasTimer, hasPoints, ended = false;
  late Widget view, pointsView = const SizedBox.shrink(), timerView = const SizedBox.shrink(), starsView = const SizedBox.shrink();
  late double DIM1 = 30, DIM2;



  void setTimer(){
    if (widget.countdown != null) timerDuration = Duration(seconds: widget.countdown!);
  }

  @override
  void initState() {
    super.initState();

    points = widget.initialPoints;
    stars = widget.initialStars;


    setTimer();





  }

  @override
  Widget build(BuildContext context) {

    print(points);

    double fontSize = 20;

    String strDigits(int n) => n.toString().padLeft(2, '0');

    if (widget.countdown!=null){
      seconds = strDigits(timerDuration.inSeconds.remainder(60));
      minutes = strDigits(timerDuration.inMinutes.remainder(60));
    }


    ImageGenerator imageGenerator = ImageGenerator(context: context);
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);

    DIM1 = imageGenerator.calculateY(30);
    DIM2 = imageGenerator.calculateX(18);

    widget.hideBackground = true;

    timerView = widget.countdown != null && widget.visible ?
    Container(
      decoration: BoxDecoration(
        color: color.Color.yellowGreenLigh.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            imageGenerator.generateImage(height: DIM2, width: DIM2, imagePath: "assets/hud/time.svg"),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: fontSize,
                ),
                child: Text(
                  '$minutes:$seconds',
                ),
              ),
            ),
          ],
        ),
      ),
    ) : const SizedBox.shrink();


    starsView = widget.visible ?
    Container(
      decoration: BoxDecoration(
        color: color.Color.yellowGreenLigh.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            imageGenerator.generateImage(height: DIM2, width: DIM2, imagePath: "assets/hud/star.svg"),
             DefaultTextStyle(
              style: TextStyle(
                color: widget.textColor,
                fontSize: fontSize,
              ),
              child: Text(
                ' $stars/3',
              ),
            ),
          ],
        ),
      ),
    )

        : const SizedBox.shrink();


    pointsView = widget.maxPoints != null && widget.visible ?
    Container(
      decoration: BoxDecoration(
        color: color.Color.yellowGreenLigh.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageGenerator.generateImage(height: DIM2, width: DIM2, imagePath: widget.pointsAsset),
            !widget.useBar ? DefaultTextStyle(
              style: TextStyle(
                color: widget.textColor,
                fontSize: fontSize,
              ),
              child: Text(
                '$points / ${widget.maxPoints}',
              ),
            )  : Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ProgressBar(
                total: widget.maxPoints!,
                filled: points,
                size: Size(imageGenerator.calculateX(imageGenerator.deviceWidth/12), imageGenerator.calculateX(imageGenerator.deviceWidth/5)/16),
              ),
            ),
          ],
        ),
      ),
    ) : const SizedBox.shrink();

    Padding frontEnd = Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          timerView,
          starsView,
          pointsView,
          buttonGenerator.generateImageButtom(
            height: DIM1,
            width: DIM1,
            borderRadius: BorderRadius.circular(10),
            imagePath: "assets/nav_buttons/pause.svg",
            onTap: (){
              onPaused();
            },
          ),
        ],
      ),
    );

    if (!widget.hideBackground && widget.visible){
      view = Material(
        elevation: 10,
        color: color.Color.yellowGreen.color,
        child: frontEnd,
      );
    } else {
      view = frontEnd;
    }


    return view;
  }

  void modifyPoints({required int points}){

    if(widget.maxPoints != null){
        setState(() {

          this.points += points;
          if (this.points < 0){
            this.points = 0;
          } else if (this.points > widget.maxPoints!){
            this.points = widget.maxPoints!;
          }

          widget.onPointsModified?.call(this.points, points);

        });

    }

  }



  void onMaxPointsReached(){
    print("MAX REACHED");
    widget.onMaxPointsReached?.call();
    onFinished();
  }

  void setStars(int stars){
    setState(() {


      if (stars < 0){
        stars = 0;
      } else if (stars > 3) {
        stars = 3;
      }
      this.stars = stars;
      widget.onStarsModified?.call(this.stars);

    });
  }




  void startTimer() {

    ended = false;
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => updateTimerView());
  }

  void stopTimer() {
    if (widget.countdown != null) setState(() => countdownTimer?.cancel());
  }

  void resetTimer() {
    ended = false;
    stopTimer();
    setState(() => timerDuration = Duration(seconds: widget.countdown!));
  }

  void updateTimerView() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = timerDuration.inSeconds - reduceSecondsBy;

      widget.onTimeUpdate?.call(Duration(seconds: seconds));

      if (seconds < 0) {
        onTimeOute();
      } else {
        timerDuration = Duration(seconds: seconds);
      }


    });
  }


  void onRestart(){
    setState(() {
      widget.restartGame?.call();
      setTimer();
      points = widget.initialPoints;
      stars = widget.initialStars;
      onStart();
    });
  }


  void onStart() async{
    if (widget.countdown != null) startTimer();
  }

  Widget createMenu({String? title}){
    print(stars.toString());
    return ScoreScreen(
      title: title,
      stars: stars,
      score: widget.maxPoints != null ? "${points}/${widget.maxPoints}" : null,
      scoreText: widget.pointsText,
      scoreAsset: widget.pointsAsset,
      time: widget.countdown != null ? timerDuration : null,
      onQuit: (){
        Navigator.of(context).pop();
        Navigator.pop(context);

      },
      onRestart: (){
        Navigator.of(context).pop();
        onRestart();
      },

    );
  }


  void onTimeOute(){

    ended = true;


    Widget menu = createMenu(title: "Temps écoulé!");

    setState(() {
      countdownTimer?.cancel();
      widget.onGameTimeOut?.call();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return menu;
        },
      );
    });
  }

  void onFinished() async{
    if (!ended) {
      Widget menu = createMenu(title: "Bravo!");

      setState(() {
        countdownTimer?.cancel();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return menu;
          },
        );

        Loading.ShowLoading(context, text: "Sauveguarde des données...");

      });
    }
  }

  void onLose(){
    setState(() {
      stars = 0;
      countdownTimer?.cancel();
      showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => createMenu(title: "You lost!!!"));
    });
  }


  void onPaused(){

    late Widget menu;
    // menu = AlertDialog(
    //   content: Text("PAUSED!!!"),
    //   actions: <Widget>[
    //     ElevatedButton(
    //       child: const Text("RESUME"),
    //       onPressed: () {
    //         startTimer();
    //         widget.resumeGame?.call();
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //     ElevatedButton(
    //       child: const Text("RESTART"),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //         onRestart();
    //       },
    //     ),
    //     ElevatedButton(
    //       child: const Text("QUIT"),
    //       onPressed: (){
    //         Navigator.of(context).pop();
    //         Navigator.pop(context);
    //       },
    //     ),
    //   ],
    // );


    menu = PauseScreen(
      onQuit: (){

        Navigator.of(context).pop();
        Navigator.pop(context);
      },
      onRestart: (){
        Navigator.of(context).pop();
        onRestart();
      },
      onResume: (){
        if (widget.countdown != null) startTimer();
        widget.resumeGame?.call();
        Navigator.of(context).pop();
      },
      sound: Info.sound,
      screenHeight: MediaQuery.of(context).size.height,
      screenWidth: MediaQuery.of(context).size.width,
    );


    setState(() {
      countdownTimer?.cancel();
      widget.onGamePaused?.call();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return menu;
        },
      );
    });

  }













  
}