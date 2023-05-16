import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'dart:math';
import 'AnimalGame.dart';
import 'Trash.dart';
import 'package:flutter/material.dart';
class Animal extends SpriteAnimationComponent with DragCallbacks,CollisionCallbacks{
  bool _isDragged=false;
  late Vector2 size2;//size of the screen
  late AnimalGame gameRef;
  Animal({ required this.size2,required this.gameRef});
  late ShapeHitbox hitbox;//La hitbox de l'animal
  @override
  Future<void> onLoad() async {
    priority=10;
    final defaultPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..collisionType=CollisionType.passive
      ..renderShape = false//ne pas l'afficher
    ..isSolid=true;//rend la hitbox solide
    //ajout de la hitbox
    add(hitbox);
  }
  @override
  void onDragStart(DragStartEvent event) {
    /// CETTE FONCTION EST UTILISE LORSQUE L'ENFANT TOUCHE LA PIECE DE PUZZLE
    super.onDragStart(event);
    _isDragged = false;
    priority = 10;
  }
  @override
  void onDragEnd(DragEndEvent event) {
    /// CETTE FONCTION EST UTILISE LORSQUE L'ENFANT LACHE LA PIECE DE PUZZLE
    super.onDragEnd(event);
    _isDragged = false;
    priority = 0;
  }
  @override
  void onDragUpdate(DragUpdateEvent event) {
    /// CETTE FONCTION EST UTILISE TANTQUE L'ENFANT A LA PIECE DE PUZZLE EN MAIN
    super.onDragUpdate(event);
    if(this.position.y<=size2[1]-this.size[1]-20 && this.position.y>= 20){
      position.y+=event.delta.y;
    }else{
      if(this.position.y<size2[1]-this.size[1] && this.position.y>size2[1]/2 && event.delta.y<=0){
        position.y+=event.delta.y;
      }else{
        if(this.position.y>0 && this.position.y<size2[1]/2 && event.delta.y>=0){
          position.y+=event.delta.y;

        }
      }
      ///POUR NE PAS DEPLACER LA TORTUE SI ELLE SORT DU CADRE PRECISE DE L'ECRAN
    }
  }
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    //remove heart
    print("You just hit an object");
    gameRef.modifyPoints(points: -1);
    gameRef.setStars(stars: gameRef.getStars()-1);
    this.add(
        SequenceEffect([
        OpacityEffect.to(
        0.3,
        EffectController(duration: 0.25),
        ),
          OpacityEffect.to(
            1,
            EffectController(duration: 0.25),
          ),
          OpacityEffect.to(
            0.3,
            EffectController(duration: 0.25),
          ),
          OpacityEffect.to(
            1,
            EffectController(duration: 0.25),
          ),
    ]
    ));
    if(gameRef.getPoints()==0){
      print("You have no hearts left");
      gameRef.onLose();//le joueur a perdu car il ne lui reste plus de vie
    }
  }
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}