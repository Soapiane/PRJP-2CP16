import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/player.dart';
import 'package:projet2cp/MiniGames/RunnerVille/game.dart';

class Leaf extends SpriteComponent
    with CollisionCallbacks, HasGameRef<ArrangerVille> {
  Leaf(
    Image image, {
    Vector2? srcPosition,
    Vector2? srcSize,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(
          image,
          srcPosition: Vector2.zero(),
          srcSize: Vector2(379, 336),
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
        );
  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox()..collisionType = CollisionType.passive);
    add(MoveEffect.by(
        Vector2(0, -3),
        EffectController(
          alternate: true,
          infinite: true,
          duration: 0.5,
        )));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      add(RemoveEffect());
      gameRef.modifyPoints(points: 1);
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
