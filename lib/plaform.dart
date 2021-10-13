import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Platform extends SpriteComponent with Hitbox, Collidable {
  Platform() : super(size: Vector2(128, 32)) {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('platform.png');
    anchor = Anchor.center;
    final hitbox = HitboxRectangle();
    addHitbox(hitbox);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = Vector2(gameSize[0] / 2, gameSize[1] - 100);
  }
}
