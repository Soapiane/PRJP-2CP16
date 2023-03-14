//
//
// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
// import 'package:projet2cp/MiniGames/MiniGame.dart';
// import 'package:projet2cp/MiniGames/TurningPipes/TurningPipes.dart';
//
// class TurningPipesGame extends MiniGame {
//
//
//   TurningPipesGame({Key? key, required super.onFinished,  super.decreasePoints,  super.increasePoints}) : super(key: key);
//
//   @override
//   _TurningPipesState createState() => _TurningPipesState();
//
// }
//
//
// class _TurningPipesState extends State<TurningPipesGame>{
//
//   late TurningPipes game;
//
//   @override
//   void initState() {
//     super.initState();
//     game = TurningPipes(
//         onFinished: widget.onFinished,
//         decreasePoints: widget.decreasePoints,
//         increasePoints: widget.increasePoints,
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GameWidget(
//           game: game,
//     );
//   }
//
// }