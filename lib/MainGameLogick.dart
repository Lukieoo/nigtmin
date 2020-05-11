import 'dart:ui';
 
import 'package:flame/game.dart';
import 'package:nigtmin/Background.dart';
import 'package:nigtmin/enemy.dart';

import 'ColidersModl.dart';
import 'Playerlatest.dart';
import 'maps.dart';

class MainLogick extends Game {
  Size screenSize;
  double tileSize;
  Background background;
  Offset offset;

  Player2 player;
  List<Enemy> enemy;

  Mapx map;
  static List<Colider> block = new List();

  Future<void> onLeftJoypadChange(Offset offset) async {
    //Get Offset by pad
  this.offset=offset;
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
        map.render(canvas);
        
     // background.render(canvas);

      if (player.position.dy > enemy[0].componentx.y) {
        enemy[2].render(canvas);
        enemy[1].render(canvas);
        enemy[0].render(canvas);
        player.render(canvas);
      } else {
        player.render(canvas);
        enemy[0].render(canvas);
        enemy[1].render(canvas);
        enemy[2].render(canvas);
      }
  
      canvas.restore();
    }
  }

  void update(double t) {
    if (screenSize != null) {
      player.update(t);
      enemy[0].update(t);
      enemy[1].update(t);
      enemy[2].update(t);
    
      
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    background = Background(this);
    map=Mapx();
 
    enemy=List();
    player = Player2(this, screenSize.width, screenSize.height);
    enemy.add(Enemy(257, 120));
    enemy.add(Enemy(400, 160));
    enemy.add(Enemy(450, 120));
 
    block.add(Colider(
        name: "enemy1",
        left: enemy[0].hitBox.left,
        top: enemy[0].hitBox.top,
        height: enemy[0].hitBox.height,
        width: enemy[0].hitBox.width));
   
    block.add(Colider(
        name: "enemy",
        left: enemy[1].hitBox.left,
        top: enemy[1].hitBox.top,
        height: enemy[1].hitBox.height,
        width: enemy[1].hitBox.width));

    block.add(Colider(
        name: "enemy2",
        left: enemy[2].hitBox.left,
        top: enemy[2].hitBox.top,
        height: enemy[2].hitBox.height,
        width: enemy[2].hitBox.width));
  }
}
