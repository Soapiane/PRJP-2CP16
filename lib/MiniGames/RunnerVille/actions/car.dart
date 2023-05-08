import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/player.dart';
import 'package:projet2cp/MiniGames/RunnerVille/game.dart';

class Car extends SpriteComponent
    with CollisionCallbacks, HasGameRef<ArrangerVille> {
  Car(
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
          srcSize: Vector2(184, 96),
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

    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      add(OpacityEffect.to(0.5, EffectController(duration: 0.5)));
      add(RemoveEffect());
      gameRef.modifyPoints(points: 10);
      gameRef.ActionChanged = true;
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
