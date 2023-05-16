import 'package:flame/collisions.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
class Trash extends SpriteComponent with CollisionCallbacks {
  late Vector2 size2;
  late double Speed;//VITESSE DES DECHETS
  Trash({required this.size2,required this.Speed})
      :super(size: Vector2.all(100));
  bool _isDragged=false;
  late bool isDragged=false;
  final _collisionStartColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  late ShapeHitbox hitbox;
  @override
  Future<void> onLoad() async {
    priority=10;
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = false
    ..isSolid=true;
    //AJOUT DE LA HITBOX
    add(hitbox);
  }
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position.x-=this.Speed*dt;
    if(position.x< -this.width){
      //LE DECHET A DEPASSE L'ECRAN
      this.removeFromParent();
    }
  }
}