import 'package:flame/game.dart';
import 'player.dart';
import 'plaform.dart';

class SunflowerDash extends FlameGame with HasCollidables {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Player());
    add(Platform());
  }
}
