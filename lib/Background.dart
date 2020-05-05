

import 'dart:ui';

import 'package:flame/sprite.dart';

import 'MainGameLogick.dart';
 

class Background{
 final MainLogick game;
 
  Sprite bgSprite;
  Rect bgRect;

  Background(this.game) {
    bgSprite = Sprite('bg/bq.png');

    bgRect = Rect.fromLTWH(
      0,
      0,
      game.screenSize.width,
      game.screenSize.height,
    );
    
  }

  void render(Canvas c) {
    
    bgSprite.renderRect(c, bgRect);

  }

  void update(double t) {}
}