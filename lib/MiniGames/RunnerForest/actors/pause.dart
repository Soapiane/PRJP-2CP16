import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game.dart';
import 'player.dart';

class Pause extends PositionComponent
    with CollisionCallbacks, HasGameRef<ArrangerForet> {
  Pause({
    required Vector2? position,
    required Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super(
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
        ) {}

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Player) {
      gameRef.pause = true;
    }
    super.onCollisionEnd(other);
  }
}
