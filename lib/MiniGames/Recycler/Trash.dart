
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'RecyclerGame.dart';
import 'Poubelle.dart';

class trash extends SvgComponent with DragCallbacks,CollisionCallbacks {
  late Poubelle premiere,deuxieme,troisieme,quatrieme;
  late int num;
  late int NbTrash;
  late Vector2 size2;
  late Vector2 _positionOriginale;
  late Vector2 position2;
  late Recycler game;
  late Vector2 sizeAsset;
  trash({
    required this.NbTrash,
    required this.game,
    required this.premiere,
    required this.deuxieme,
    required this.troisieme,
    required this.quatrieme,
    required this.num,
    required this.sizeAsset,
    required this.size2,
    required this.position2,
  }){
    this.size=sizeAsset;
  }
  bool _isDragged=false;
  late bool isDragged=false;
  final _collisionStartColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  late ShapeHitbox hitbox;
  @override
  Future<void> onLoad() async {
    _positionOriginale=this.position2.clone();
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = false;
    add(hitbox);
  }
  @override
  void onDragStart(DragStartEvent event) {
    _isDragged = true;
    priority = 10;
    isDragged=_isDragged;
  }
  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    priority = 0;
    isDragged=_isDragged;
    if(premiere.isColliding || deuxieme.isColliding || troisieme.isColliding || quatrieme.isColliding){

      removeFromParent();
      if((premiere.isColliding && premiere.num==this.num ) || (deuxieme.isColliding && deuxieme.num==this.num ) || (troisieme.isColliding && troisieme.num==this.num )|| (quatrieme.isColliding && quatrieme.num==this.num )  ){
        print("good");
        game.modifyPoints(points: 1);
        if(game.getPoints()>=(game.hud.maxPoints!)/3 &&game.hud.getPoints()<(game.hud.maxPoints!)*2/3){
          game.setStars(stars: 1);
        }else{
          if(game.getPoints()>=(game.hud.maxPoints!)*2/3  && game.hud.getPoints()<(game.hud.maxPoints!)){
            game.setStars(stars: 2);

          }else{
            if(game.getPoints()==(game.hud.maxPoints!)){
              game.setStars(stars: 3);

            }
          }
        }
      }else{
        print("bad");
      }
      if(NbTrash==game.hud.maxPoints!){
        if(game.hud.getStars()>0){
          game.onFinished();
        }else{
          game.onLose();
        }
      }
    }else{
      this.position=_positionOriginale;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    this.position += event.delta;
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(isDragged==false){
      this.x+=size2[0]/10*dt;
    }
    _positionOriginale.x+=size2[0]/10*dt;
    if(_positionOriginale.x>size2[0]+this.width){
      removeFromParent();
      if(NbTrash==game.hud.maxPoints!){
        if(game.hud.getStars()>0){
          game.onFinished();
        }else{
          game.onLose();
        }
      }
    }
  }
}