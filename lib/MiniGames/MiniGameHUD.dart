


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Zone/Zones.dart';

class MiniGameHUD extends StatefulWidget{

  Zones zone;
  Function onPause, onTimeOut;
  Function? onFinished;
  int countdown;
  int? points;
  String? pointsAsset;




  MiniGameHUD({required this.zone, required this.countdown, this.points, this.pointsAsset , required this.onPause,  required this.onTimeOut});

  @override
  State<StatefulWidget> createState() => _MiniGameHUDState();


}


class _MiniGameHUDState extends State<MiniGameHUD>{



  late Timer countdownTimer;
  late Duration timerDuration;
  late String seconds, minutes;

  @override
  void initState() {
    super.initState();

    widget.onFinished = endLevel;

    timerDuration = Duration(seconds: widget.countdown);

    startTimer();

  }


  void startTimer() {

    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => updateTimerView());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => timerDuration = Duration(days: 5));
  }

  void updateTimerView() {
    print("update");
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = timerDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        timerDuration = Duration(seconds: seconds);
      }
    });
  }


  void endLevel(){
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
        },
      );
    });
  }






  @override
  Widget build(BuildContext context) {

    String strDigits(int n) => n.toString().padLeft(2, '0');

    seconds = strDigits(timerDuration.inSeconds.remainder(60));
    minutes = strDigits(timerDuration.inMinutes.remainder(60));

    return Text(
      '$minutes:$seconds',
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }
  
}