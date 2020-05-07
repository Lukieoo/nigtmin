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
  Enemy enemy1;
  Enemy enemy2;
  static List<Colider> block = new List();

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
    // print("hit");
  }

  MainLogick() {
    initialize();
  }

  void initialize() async {}

  void render(Canvas canvas) {
    if (screenSize != null) {
      background.render(canvas);

      if (player.position.dy > enemy.componentx.y) {
        enemy2.render(canvas);
        enemy1.render(canvas);
        enemy.render(canvas);
        player.render(canvas);
      } else {
        player.render(canvas);
        enemy.render(canvas);
        enemy1.render(canvas);
        enemy2.render(canvas);
      }

      canvas.restore();
    }
  }

  void update(double t) {
    if (screenSize != null) {
      player.update(t);
      enemy.update(t);
      enemy1.update(t);
      enemy2.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    background = Background(this);

    player = Player2(this, screenSize.width, screenSize.height);
    enemy = Enemy(257, 120);
    enemy1 = Enemy(400, 160);
    enemy2 = Enemy(450, 120);

    // print("enemy ${enemy.hitBox.left}   ${enemy.hitBox.top}  ${enemy.hitBox.height}  ${enemy.hitBox.width}");
    block.add(Colider(
        name: "enemy1",
        left: enemy1.hitBox.left,
        top: enemy1.hitBox.top,
        height: enemy1.hitBox.height,
        width: enemy1.hitBox.width));
    print(
        "enemy ${enemy.hitBox.left}   ${enemy.hitBox.top}  ${enemy.hitBox.height}  ${enemy.hitBox.width}");

    block.add(Colider(
        name: "enemy",
        left: enemy.hitBox.left,
        top: enemy.hitBox.top,
        height: enemy.hitBox.height,
        width: enemy.hitBox.width));

    block.add(Colider(
        name: "enemy2",
        left: enemy2.hitBox.left,
        top: enemy2.hitBox.top,
        height: enemy2.hitBox.height,
        width: enemy2.hitBox.width));
  }
}
