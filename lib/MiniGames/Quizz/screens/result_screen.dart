import 'package:flutter/material.dart';
import 'package:projet2cp/Navigation/Zones.dart';

import '../quizzGame.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  const ResultScreen(this.score, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Color mainColor = const Color.fromARGB(255, 72, 99, 99);
  Color secondColor = const Color.fromARGB(255, 65, 76, 66);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Congrats",
              style: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 45.0,
            ),
            Text(
              "${widget.score}",
              style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w300),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizzGame(zone: Zones.ville)));
              },
              color: Colors.blueGrey,
              textColor: Colors.black26,
              child: Text("Replay Quizz"),
            )
          ]),
    );
  }
}
