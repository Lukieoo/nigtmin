import 'dart:ui';

import 'package:flame/components/animation_component.dart';

class Enemy {

   
  AnimationComponent componentx;
  double width = 0;
  double height = 0;

  Rect hitBox;
  Enemy() {
     hitBox = Rect.fromLTWH(257, 120+(64*(2/3)), 30, 64/3);
    componentx = AnimationComponent.sequenced(
      64.0,
      64.0,
      'hero.png',
      5,
      textureY: 128,
      textureWidth: 64.0,
      textureHeight: 64.0,
    );

    componentx.y =  120;
    componentx.x =  240 ;
  }

  void render(Canvas c) {
    
     
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574).withOpacity(0.9);
    c.drawRect(hitBox, bgPaint);
    componentx.render(c);
    c.restore();
    c.save();
  }

  void update(double t) {
    componentx.animation.update(t*0.5);
  }
}
