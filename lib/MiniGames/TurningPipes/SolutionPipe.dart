

import 'Pipe.dart';

class SolutionPipe extends Pipe{

  List<Angle> solutions;

  SolutionPipe({
    required this.solutions,
    super.locked,
    super.pipeHeight,
    super.pipeWidth,
    super.posX,
    super.posY,
    super.rotateDuration,
    super.type,
    super.pipeAngle,
    super.onTurn,
  }) : super();

  bool isSolved(){
    bool solved = false;
    print("Current angle: " + pipeAngle.toString());
    print("solution angles: ");
    for (var angle in solutions){

      print(angle.toString());
      solved = (pipeAngle == angle);
      print("Pipe solved: " + solved.toString());

      if (solved) break;
    }

    return solved;
  }



}