


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/StandardWidgets.dart';
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:projet2cp/Color.dart' as color;

class MiniGameHUD extends StatefulWidget{

  Zones zone;
  int? countdown;
  int? maxPoints;
  int initialPoints, initialStars;
  String pointsAsset;
  late _MiniGameHUDState state;
  Function? onGameTimeOut, onGamePaused, resumeGame, restartGame, onMaxPointsReached;
  Function(int)?  onStarsModified;
  Function(int, int)? onPointsModified;
  Function(Duration)? onTimeUpdate;




  MiniGameHUD({super.key, required this.zone, this.countdown, this.maxPoints, this.pointsAsset = "assets/hud/points.svg", this.initialPoints = 0, this.initialStars = 0}){

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
  late bool hasTimer, hasPoints;
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

    String strDigits(int n) => n.toString().padLeft(2, '0');

    if (widget.countdown!=null){
      seconds = strDigits(timerDuration.inSeconds.remainder(60));
      minutes = strDigits(timerDuration.inMinutes.remainder(60));
    }


    ImageGenerator imageGenerator = ImageGenerator(context: context);
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);

    DIM1 = imageGenerator.calculateY(30);
    DIM2 = imageGenerator.calculateY(24);

    timerView = widget.countdown != null ?
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [

        imageGenerator.generateImage(height: DIM2, width: DIM2, imagePath: "assets/hud/time.svg"),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            '$minutes:$seconds',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 25,
            ),
          ),
        ),
      ],
    ) : const SizedBox.shrink();


    starsView = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        imageGenerator.generateImage(height: DIM2, width: DIM2, imagePath: "assets/hud/star.svg"),
        Text(
          ' $stars/3',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 25,
          ),
        ),
      ],
    );


    pointsView = widget.maxPoints != null ?
    Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imageGenerator.generateImage(height: DIM2, width: DIM2, imagePath: widget.pointsAsset),
        Text(
          '$points / ${widget.maxPoints}',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 25,
          ),
        ),
      ],
    ) : const SizedBox.shrink();

    view = Material(
      elevation: 10,
      color: color.Color.yellowGreen.color,
      child: Padding(
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
      ),
    );

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

          if (this.points == widget.maxPoints){
            onMaxPointsReached();
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

    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => updateTimerView());
  }

  void stopTimer() {
    setState(() => countdownTimer?.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => timerDuration = Duration(seconds: widget.countdown!));
  }

  void updateTimerView() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = timerDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        onTimeOute();
      } else {
        timerDuration = Duration(seconds: seconds);
      }

      widget.onTimeUpdate?.call(timerDuration);

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


  void onStart(){
    startTimer();
  }

  AlertDialog createMenu(String title){
    return AlertDialog(
      content: Text(title),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Quit"),
          onPressed: () {

            Navigator.of(context).pop();
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text("Restart"),
          onPressed: () {
            Navigator.of(context).pop();
            onRestart();
          },
        ),
      ],
    );
  }


  void onTimeOute(){

    Widget menu = createMenu("Your time is out!!!");

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

  void onFinished(){


    Widget menu = createMenu("You finished the game!!!");

    setState(() {
      countdownTimer?.cancel();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return menu;
        },
      );
    });
  }

  void onLose(){
    setState(() {
      countdownTimer?.cancel();
      showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => createMenu("You lost!!!"));
    });
  }


  void onPaused(){

    Widget menu = AlertDialog(
      content: Text("PAUSED!!!"),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("RESUME"),
          onPressed: () {
            startTimer();
            widget.resumeGame?.call();
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text("RESTART"),
          onPressed: () {
            Navigator.of(context).pop();
            onRestart();
          },
        ),
        ElevatedButton(
          child: const Text("QUIT"),
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.pop(context);
          },
        ),
      ],
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