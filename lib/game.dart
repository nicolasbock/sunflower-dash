import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/geometry.dart';

import 'player.dart';
import 'plaform.dart';

class SunflowerDash extends FlameGame
    with HasCollidables, HasDraggableComponents, HasTappableComponents {
  late final Player player;
  late final JoystickComponent joystick;
  late final HudButtonComponent button;
  late final Platform platform;
  late final ScreenCollidable screen;

  SunflowerDash();
  @override
  Future<void> onLoad() async {
    super.onLoad();

    screen = ScreenCollidable();

    add(screen);

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();

    joystick = JoystickComponent(
      knob: Circle(radius: 20).toComponent(paint: knobPaint),
      background: Circle(radius: 60).toComponent(paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 10, bottom: 10),
    );

    add(joystick);

    player = Player(joystick, screen);
    add(player);

    button = HudButtonComponent(
      button: Circle(radius: 20).toComponent(paint: knobPaint),
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      onPressed: () => player.jump(),
    );

    add(button);

    platform = Platform();

    add(platform);
  }
}
