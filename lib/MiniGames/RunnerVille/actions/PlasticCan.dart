import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:projet2cp/MiniGames/RunnerVille/actors/player.dart';
import 'package:projet2cp/MiniGames/RunnerVille/game.dart';

class PlasticCan extends SpriteComponent with CollisionCallbacks {
  PlasticCan(
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
          srcSize: Vector2(166, 280),
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
    add(OpacityEffect.to(0.0, EffectController(duration: 0)));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      add(OpacityEffect.to(1, EffectController(duration: 0.8)));
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
