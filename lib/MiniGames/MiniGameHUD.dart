


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Zones.dart';

class MiniGameHUD extends StatefulWidget{

  Zones zone;
  int? countdown;
  int? maxPoints;
  String? pointsAsset;
  late _MiniGameHUDState state;
  Function? onGameTimeOut, onGamePaused, resumeGame, restartGame;




  MiniGameHUD({super.key, required this.zone, this.countdown, this.maxPoints, this.pointsAsset}){
    state = _MiniGameHUDState();
  }

  void onFinished(){
    state.onFinished();
  }


  void modifyPoints({required int points}){
    state.modifyPoints(points: points);
  }



  @override
  State<StatefulWidget> createState() {
    return state;
}


}


class _MiniGameHUDState extends State<MiniGameHUD>{



  Timer? countdownTimer;
  late Duration timerDuration;
  late String seconds, minutes;
  int points = 0;
  late bool hasTimer, hasPoints;

  @override
  void initState() {
    super.initState();


    if (widget.countdown != null){
      timerDuration = Duration(seconds: widget.countdown!);
      startTimer();
    }

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
        });

    }

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
    });
  }


  void onTimeOute(){

    Widget menu = AlertDialog(
      content: Text("Your time is out!!!"),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    setState(() {
      countdownTimer?.cancel();
      widget.onGameTimeOut?.call();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return menu;
        },
      );
    });
  }


  void onFinished(){


    Widget menu = AlertDialog(
      content: Text("Congrats!!!"),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Thank you"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    setState(() {
      countdownTimer?.cancel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return menu;
        },
      );
    });
  }


  void onPaused({Function? resumeFunction, Function? restartFunction}){

    Widget menu = AlertDialog(
      content: Text("PAUSED!!!"),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("RESUME"),
          onPressed: () {
            widget.resumeGame?.call();
            Navigator.of(context).pop();
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







  @override
  Widget build(BuildContext context) {

    String strDigits(int n) => n.toString().padLeft(2, '0');

    if (widget.countdown!=null){
      seconds = strDigits(timerDuration.inSeconds.remainder(60));
      minutes = strDigits(timerDuration.inMinutes.remainder(60));
    }

    return widget.countdown != null ?
    Text(
      '$minutes:$seconds',
      style: const TextStyle(
        color: Colors.red,
      ),
    ) : widget.maxPoints != null ?
    Text(
      '$points / ${widget.maxPoints}',
      style: const TextStyle(
        color: Colors.red,
      ),
    ) : Material(
      child: testWidget(),
    );
  }



  Widget testWidget() {
    return InkWell(
      hoverColor: Colors.blue,
      onTap: onPaused,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/map_horizontal_point.png",
            fit: BoxFit.fitWidth,
            width: 50.0,
          ),
          const Text("pause",
              style: TextStyle(color: Colors.black, fontSize: 16)
          ),
        ],
      ),
    );

  }
  
}