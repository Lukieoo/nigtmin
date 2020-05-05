import 'dart:ui';

import 'package:flame/game.dart';
import 'package:nigtmin/Background.dart';
import 'package:nigtmin/enemy.dart';

import 'ColidersModl.dart';
import 'Playerlatest.dart';

class MainLogick extends Game {
  Size screenSize;
  double tileSize;
  Background background;

  Player2 player;
  Enemy enemy;
  static List<Colider> block=new List();

  Future<void> onLeftJoypadChange(Offset offset) async {
    //Get Offset by pad

    if (offset == Offset.zero) {
      player.targetBodyAngle = null;
    } else {
      player.targetBodyAngle = offset.direction;
    }

    player.posYoyPad = offset;
  }

  //Game Hit
  Future<void> onHit(bool heHit) async {
    player.onHit(heHit);
    print("hit");
  }

  MainLogick() {
    initialize();
  }

  void initialize() async {}

  void render(Canvas canvas) {
    if (screenSize != null) {
      background.render(canvas);

      enemy.render(canvas);

      player.render(canvas);
      canvas.restore();
    }
  }

  void update(double t) {
    if (screenSize != null) {
      player.update(t);
      enemy.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    background = Background(this);

    player = Player2(this, screenSize.width, screenSize.height);
    enemy = Enemy();

    block.add(Colider(
        name: "enemy",
        left: enemy.componentx.x,
        top: enemy.componentx.y,
        height: 64,
        width: 64));

  }
}
