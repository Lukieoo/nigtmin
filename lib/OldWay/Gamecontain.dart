import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

import 'Player.dart';

class GameMaps extends BaseGame {
  final Size size;
  Player player;
 Sprite bgSprite;
  double width = 0;
  double height = 0;

  //Game Joypad
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

  //inialization Game component
  GameMaps({this.size}) {
    // background = Background(this);
    height = size.height / 2 - 48;
    width = size.width / 2 - 48;
      bgSprite = Sprite('bg/bq.png');
    add(SpriteComponent.fromSprite(size.width, size.height, bgSprite));
     
    player = Player(this, width, height);
  }

//Game Loop
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
  }

  @override
  void update(double t) {
    super.update(t);
    //add(SpriteComponent.fromSprite(size.width, size.height, bgSprite));
    player.update(t);
    
    
  }

  @override
  Color backgroundColor() => const Color(0xff27ae60);
}
