import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';
import 'plaform.dart';

class Player extends SpriteComponent with Hitbox, Collidable {
  var speed = Vector2.zero();
  final maxSpeed = 400;
  var acceleration = Vector2(0, 120);
  var platformCollision = false;
  var screenCollision = false;
  final JoystickComponent joystick;
  final ScreenCollidable screen;

  Player(this.joystick, this.screen) : super(size: Vector2.all(32)) {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('ball.png');
    anchor = Anchor.center;
    final hitbox = HitboxRectangle();
    addHitbox(hitbox);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Platform) {
      if (!platformCollision) {
        platformCollision = true;
        speed = Vector2.zero();
        // Adjust position so that the player sits on the platform and is not
        // partially in the platform.
        // TODO: Fix collision from side and bottom.
        position += Vector2(0, other.center.y - center.y - 32);
        print('Hit platform!');
      } else {
        print('Ignoring platorm collision');
      }
    } else if (other is ScreenCollidable) {
      if (!screenCollision) {
        screenCollision = true;
        speed = Vector2.zero();
        position += Vector2(0, other.size.y - center.y - 16);
        print('Going out of bounds');
      } else {
        print('Ignoring screen collision');
      }
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    if (other is Platform) {
      if (platformCollision) {
        platformCollision = false;
      }
    } else if (other is ScreenCollidable) {
      if (screenCollision) {
        screenCollision = false;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * 80 * dt);
    }
    if (!platformCollision && !screenCollision) {
      speed += acceleration * dt;
    }
    if (speed.length > maxSpeed) {
      speed *= maxSpeed / speed.length;
    }
    position += speed * dt;
  }

  void jump() {
    print("jumping");
    speed -= Vector2(0, 60);
    platformCollision = false;
  }
}
