import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:projet2cp/MiniGames/RunnerForest/game.dart';

class Attention extends SpriteComponent
    with CollisionCallbacks, HasGameRef<ArrangerForet> {
  Attention(
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
          srcSize: Vector2.all(512),
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
        );
  @override
  FutureOr<void> onLoad() {
    add(MoveEffect.by(
        Vector2(0, -5),
        EffectController(
          alternate: true,
          infinite: true,
          duration: 0.5,
        )));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (gameRef.ActionChanged) {
      add(OpacityEffect.to(
          0.05,
          EffectController(
            duration: 0.2,
          ))
        ..onComplete = () => add(RemoveEffect()));
    }
    gameRef.ActionChanged = false;

    super.update(dt);
  }
}
