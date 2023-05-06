import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'player.dart';

class PlayerPosition extends PositionComponent {
  PlayerPosition({
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
}
