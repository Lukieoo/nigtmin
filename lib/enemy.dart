import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flutter/material.dart';

class Enemy {
  double posx;
  double posy;

  AnimationComponent componentx;
  double width = 0;
  double height = 0;
  String tekst;
  Rect hitBox;
  Enemy(this.posx, this.posy) {
    hitBox = Rect.fromLTWH(posx+17, posy + (64 * (2 / 3)), 30, 64 / 3);
    componentx = AnimationComponent.sequenced(
      64.0,
      64.0,
      'hero.png',
      5,
      textureY: 128,
      textureWidth: 64.0,
      textureHeight: 64.0,
    );

    componentx.y = posy;
    componentx.x = posx;
    tekst = "lt(${hitBox.left.toInt()},${hitBox.top.toInt()}) , rt(${(hitBox.left + hitBox.width).toInt()},${hitBox.top.toInt()} ) ,\n" +
        " lb(${hitBox.left.toInt()},${hitBox.top.toInt() + hitBox.height.toInt()}) , rb(${hitBox.left.toInt() + hitBox.width.toInt()},${hitBox.top.toInt() + hitBox.height.toInt()})";
  }

  void render(Canvas c) {
    // Paint bgPaint = Paint();
    // bgPaint.color = Color(0xff576574).withOpacity(0.9);
    // c.drawRect(hitBox, bgPaint);
    componentx.render(c);
    //TEXT
    // TextSpan span =
    //     new TextSpan(style: new TextStyle(color: Colors.black), text: tekst);
    // TextPainter tp = new TextPainter(
    //     text: span,
    //     textWidthBasis: TextWidthBasis.longestLine,
    //     textAlign: TextAlign.left,
    //     textDirection: TextDirection.ltr);

    // tp.layout();
    // tp.paint(c, new Offset(0.0, -20.0));
    //
    c.restore();
    c.save();
  }

  void update(double t) {
    componentx.animation.update(t * 0.5);
  }
}
