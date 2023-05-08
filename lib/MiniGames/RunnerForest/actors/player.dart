import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import '../game.dart';
import 'platform.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<ArrangerForet> {
  final Vector2 _velocity = Vector2.zero();
  final double _gravity = 10;
  final double _jumpSpeed = 150;
  final double _moveSpeed = 220;
  bool _isOnGround = false;
  late Vector2 _minClamp = Vector2.zero();
  late Vector2 _maxClamp = Vector2.zero();
  //defining the constructor for Earth from Image
  Player({
    required Rect levelBounds,
  }) : super() {
    final halfSize = (size!) / 2;
    _minClamp = levelBounds.topLeft.toVector2() + (halfSize);
    _maxClamp = levelBounds.bottomRight.toVector2() - halfSize;
  }

  @override
  FutureOr<void> onLoad() async {
    //when the object is loaded (appreas on screen)
    await add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _velocity.y += _gravity; //the vertical movement only depends on gravity
    //dt : time elapsed since update got called
    if (gameRef.pause && !(gameRef.jumpInput)) {
      gameRef.pause = false;
      gameRef.onLose();
    }
    if (gameRef.stop) {
      gameRef.stop = false;
      _velocity.y = _gravity;
      gameRef.player.animation = gameRef.idle;
      _velocity.x = 0;
      gameRef.onFinished();
    } else {
      if (_isOnGround) {
        if (gameRef.hAxisInput) {
          _velocity.x = _moveSpeed;
          gameRef.player.animation = gameRef.running;
        } else {
          _velocity.x = 0;
          gameRef.player.animation = gameRef.idle;
          _velocity.y = 0;
        }
      }

      if (gameRef.jumpInput && gameRef.hAxisInput) {
        if (_isOnGround) {
          _velocity.y =
              -_jumpSpeed; // -_jumpSpeed : when player jumps this will modify _velocity.y towards the upper direction which is negative
          gameRef.player.animation = gameRef.jumping;
          _isOnGround = false;
        }
        gameRef.jumpInput = false; //resset to false so he can stop jumping
      }
    }
    if (gameRef.getPoints() * (100 / gameRef.MaxPoints) > 40) {
      gameRef.setStars(stars: 1);
    }
    if (gameRef.getPoints() * (100 / gameRef.MaxPoints) > 70) {
      gameRef.setStars(stars: 2);
    }
    if (gameRef.getPoints() == gameRef.MaxPoints) {
      gameRef.setStars(stars: 3);
    }
    _velocity.y = _velocity.y.clamp(-_jumpSpeed,
        150); //to avoid high velocities as it will keep on getting higher
    position += _velocity * dt; //respects the euation of linear velocity

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //method that is used to detect collisions between earth and other objects
    if (other is Platform) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;
        final collisionNormal = absoluteCenter - mid;
        final seperationDistance = (size.x / 2) - collisionNormal.length;

        collisionNormal.normalize();
        if (Vector2(0, -1).dot(collisionNormal) > 0.9) {
          _isOnGround = true;
        }

        position += collisionNormal.scaled(seperationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
