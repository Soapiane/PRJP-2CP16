import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'player.dart';

class Wall extends PositionComponent with CollisionCallbacks {
  Function? onEarthEnter;
  Wall({
    this.onEarthEnter,
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
        );

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      onEarthEnter?.call();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
