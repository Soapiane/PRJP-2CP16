import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flame_svg/svg_component.dart';
import 'package:flame_svg/svg.dart';
class Poubelle extends SvgComponent with CollisionCallbacks {
  late double num;
    Poubelle({required Vector2 position,required this.num})
      :super(position: position,size: Vector2.all(160),anchor: Anchor.center);
  final _collisionStartColor = Colors.red;
  final _defaultColor = Colors.cyan;
  late ShapeHitbox hitbox;
  bool is_hit=false;
  bool isInEffect=false;
  @override
  Future<void> onLoad() async {
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..isSolid=true
      ..renderShape = false;
    add(hitbox);
  }
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    this.add(
        SequenceEffect([
          ScaleEffect.by(
            Vector2.all(1.15),
            EffectController(
              duration: 0.15,
            ),
          )
        ])
    );
    hitbox.paint.color = _collisionStartColor;
    is_hit=true;
  }
  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding){
      hitbox.paint.color = _defaultColor;
      is_hit=false;
      this.add(SequenceEffect([
        ScaleEffect.by(
          Vector2.all(1/1.15),
          EffectController(
            duration: 0.15,
          ),
        )
      ]));
    }
  }
  @override
  bool get_is_hit(){
    return is_hit;
  }
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}