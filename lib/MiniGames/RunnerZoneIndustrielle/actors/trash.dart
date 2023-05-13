import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../game.dart';
import 'player.dart';

class Trash extends SpriteComponent
    with CollisionCallbacks, HasGameRef<ArrangerZone> {
  Trash(
    Image image, {
    required double x,
    required double y,
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
          srcPosition: Vector2(64 * x, 64 * y),
          srcSize: Vector2.all(64),
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
        Vector2(0, -4),
        EffectController(
          alternate: true,
          infinite: true,
          duration: 0.5,
        )));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      //when Earth hits oject it will be removed
      Set<Vector2> intersectionPoints,
      PositionComponent other) {
    if (other is Player) {
      gameRef.modifyPoints(points: 1);

      add(RemoveEffect());
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
