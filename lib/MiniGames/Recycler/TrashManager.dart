import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_svg/svg.dart';

import 'Poubelle.dart';
import 'RecyclerGame.dart';
import 'Trash.dart';
import 'Trash.dart';

class TrashManager extends Component with HasGameRef{
  late trash Trash;
  late Vector2 size2;
  late final Vector2 position_spawn;//le 2 pour sauvegarder
  late Poubelle premiere,deuxieme,troisieme,quatrieme;
  late double size_tapisY;
  late Recycler gameRef;
  late List<Svg> TabAsset;
  late Timer time;
  late double time_interval;
  Random random = Random();
  TrashManager({
    required this.time_interval,
    required this.TabAsset,
    required this.gameRef,
    required this.premiere,
    required this.deuxieme,
    required this.troisieme,
    required this.quatrieme,
    required this.size2,
    required this.position_spawn, //position de spawn
    required this.size_tapisY,
  });
  late int Rand;
  late int num;
  void spawnTrash(){
    random=new Random();
    Rand = random.nextInt(16);
    if(Rand>=0 && Rand<4){
      num=1;
    }else{
      if(Rand>=4 && Rand<8){
        num=2;
      }else{
        if(Rand>=8 && Rand<12){
          num=3;
        }else{
          if(Rand>=12 && Rand<16){
            num=4;
          }
        }
      }
    }
    Vector2 newPositionSpawn = Vector2.copy(position_spawn);
    trash nouveau=new trash(
      game: this.gameRef,
      premiere: premiere,
      deuxieme: deuxieme,
      troisieme: troisieme,
      quatrieme: quatrieme,
      num: num,
      sizeAsset:Vector2(size2[0]/8,size_tapisY*3/5),
      size2:size2,
      position2: newPositionSpawn,
    );
    nouveau..svg=TabAsset[Rand]
      ..size=Vector2(size2[0]/8,size_tapisY*3/5)
      ..position=newPositionSpawn;
    add(nouveau);

  }
  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    spawnTrash();
    time=Timer(time_interval,onTick:spawnTrash,repeat: true);

    time.start();
  }
  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
    time.stop();
  }
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    time.update(dt);
  }
  void reset(){
    time.stop();
    time.start();
    children.whereType<trash>().forEach((trash) {
      trash.removeFromParent();
    });
    spawnTrash();

  }
  void Stop(){
    time.stop();
    children.whereType<trash>().forEach((trash) {
      trash.removeFromParent();
    });
  }
}