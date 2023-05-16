
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
    required this.NbTrash,//le nb de dechets total
    required this.game,//la reference au jeu
    required this.premiere,//premire poubelle
    required this.deuxieme,//poubelle n2
    required this.troisieme,//poubelle n3
    required this.quatrieme,//poubelle n4
    required this.num,
    required this.sizeAsset,
    required this.size2,//Taille de l'ecran
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
    //ON SAUVEGARDE LA POSITION
    _positionOriginale=this.position2.clone();
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = false;
    //ON AJOUTE LA HITBOX
    add(hitbox);
  }
  @override
  void onDragStart(DragStartEvent event) {
    /// CETTE FONCTION EST UTILISE LORSQUE L'ENFANT TOUCHE LA PIECE DE PUZZLE
    _isDragged = true;
    priority = 10;
    isDragged=_isDragged;
  }
  @override
  void onDragEnd(DragEndEvent event) {
    /// CETTE FONCTION EST UTILISE LORSQUE L'ENFANT LACHE LA PIECE DE PUZZLE
    _isDragged = false;
    priority = 0;
    isDragged=_isDragged;
    if(premiere.isColliding || deuxieme.isColliding || troisieme.isColliding || quatrieme.isColliding){

      removeFromParent();
      if((premiere.isColliding && premiere.num==this.num ) || (deuxieme.isColliding && deuxieme.num==this.num ) || (troisieme.isColliding && troisieme.num==this.num )|| (quatrieme.isColliding && quatrieme.num==this.num )  ){
        print("good");
        ///Le dechet a ete mit a la bonne place nous allons incrementer le score
        game.modifyPoints(points: 1);
        if(game.getPoints()>=(game.hud.maxPoints!)/3 &&game.hud.getPoints()<(game.hud.maxPoints!)*2/3){
          ///DES QUE L'UTILISATEUR ATTEINT 1/3 DES POINT MAX IL A 1 ETOILE
          game.setStars(stars: 1);
        }else{
          if(game.getPoints()>=(game.hud.maxPoints!)*2/3  && game.hud.getPoints()<(game.hud.maxPoints!)){
            ///DES QUE L'UTILISATEUR ATTEINT 2/3 DES POINT MAX IL A 2 ETOILES
            game.setStars(stars: 2);

          }else{
            if(game.getPoints()==(game.hud.maxPoints!)){
              ///DES QUE L'UTILISATEUR ATTEINT LES POINTS MAX IL A 3 ETOILES

              game.setStars(stars: 3);

            }
          }
        }
      }else{
        //mauvais choix
        print("bad");
      }
      if(NbTrash==game.hud.maxPoints!){
        if(game.hud.getStars()>0){
          game.onFinished();//FIN DU JEU
        }else{
          game.onLose();//L'UTILISATEUR A PERDU CAR IL A 0 ETOILES
        }
      }
    }else{
      this.position=_positionOriginale;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    /// CETTE FONCTION EST UTILISE TANTQUE L'ENFANT A LA PIECE DE PUZZLE EN MAIN
    this.position += event.delta;
  }
  @override
  void update(double dt) {
    ///est appele chaque dt selon la vitesse du processeur
    super.update(dt);
    if(isDragged==false){
      this.x+=size2[0]/10*dt;
    }
    _positionOriginale.x+=size2[0]/10*dt;
    if(_positionOriginale.x>size2[0]+this.width){
      removeFromParent();
      if(NbTrash==game.hud.maxPoints!){
        if(game.hud.getStars()>0){
          game.onFinished();//FIN DU JEU
        }else{
          game.onLose();//L'UTILISATEUR A PERDU CAR IL A 0 ETOILES
        }
      }
    }
  }
}