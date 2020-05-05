import 'dart:ui';

import 'package:flame/game.dart';
import 'package:nigtmin/Background.dart';

import 'Playerlatest.dart';

class MainLogick extends Game {
  Size screenSize;
  double tileSize;
  Background background;

  Player2 player;

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
  }

  MainLogick() {
    initialize();
  }

  void initialize() async {}

  void render(Canvas canvas) {
    if (screenSize != null) {
      background.render(canvas);
      player.render(canvas);
    }
  }

  void update(double t) {
    if (screenSize != null) {
      player.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    background = Background(this);
    player = Player2(this, screenSize.width, screenSize.height);
  }
}
