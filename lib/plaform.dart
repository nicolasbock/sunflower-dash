import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Platform extends SpriteComponent with Hitbox, Collidable {
  Vector2 pos;

  Platform(this.pos) : super(size: Vector2(128, 32)) {
    debugMode = true;
    print('setting platform position');
    position = pos;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('platform.png');
    anchor = Anchor.center;
    final hitbox = HitboxRectangle();
    addHitbox(hitbox);
  }
}
