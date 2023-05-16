
import 'dart:math';

import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'dart:math' as math;

enum Angle {
  up,//0
  left,//1
  down,//2
  right,//3
}

enum Type {
  straight,//0
  straightB,//1
  curved,//2
  curvedB,//3
  threeDirections,//4
  threeDirectionsU,//5
  threeDirectionsL,//6
  threeDirectionsR,//7
  fourDirections,//8
  fourDirectionsU,//9
  fourDirectionsL,//10
  fourDirectionsD,//11
  fourDirectionsR,//12
}



class Pipe extends SpriteComponent with Tappable{


  /**
   * each pipe has an angel and position and a type
   * there's locked pipes which are the side ones that represents the source and the destination
   */




  final bool locked;
  bool? rotating;
  double pipeHeight, pipeWidth, posX , posY, rotateDuration;
  Angle pipeAngle;
  Type type;
  Function? onTurn;

  Pipe({
        this.locked = false,
        this.pipeHeight=128.0,
        this.pipeWidth = 128.0,
        this.posX= 64.0,
        this.posY = 64.0,
        this.rotateDuration = 0.3,
        this.type = Type.straight,
        this.pipeAngle = Angle.up,
        this.onTurn,
      }) {
    super.size = Vector2(pipeHeight, pipeWidth);
    loadSprite();
    super.position = Vector2(posX, posY);
    super.angle = pipeAngle.index*(-1)*math.pi/2;
    super.anchor = Anchor.center;
    rotating = false;






  }

  Future<void> loadSprite() async {
    super.sprite = await Sprite.load('TurningPipes/${type.name}.png');
  }




  @override
  bool onTapDown(TapDownInfo info) {
    if (!locked) {
      if (!rotating!) {
        rotating = true;
        super.add(RotateEffect.by(
            (-1) * math.pi / 2,
            EffectController(duration: rotateDuration),
            onComplete: () {
              rotating = false;
              pipeAngle = Angle.values[(pipeAngle.index+1)%Angle.values.length];
              onTurn?.call();
            },
        )
        );
      }


    }
    return super.onTapDown(info);
  }


  void shuffle(){
    if (!locked) {
      if (!rotating!) {
        int rand = Random().nextInt(4);
        rotating = true;
        super.add(RotateEffect.to(
            rand*(-1)*math.pi/2,
            EffectController(duration: rotateDuration),
            onComplete: () {
              rotating = false;
              pipeAngle = Angle.values[rand];
            },
        )
        );
      }
    }
  }










}
