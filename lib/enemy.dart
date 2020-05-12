import 'dart:math';
import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flutter/material.dart';
import 'Playerlatest.dart' as position;

class Enemy {
  double posx;
  double posy;

  String namefile;
 static AnimationComponent componentx;
  AnimationComponent componentxCopy;
  double width = 0;
  double height = 0;
  static String tekst="100";
  Rect hitBox;
  Offset offset;
  double bodyAngle = 0;
  double cameraFrame = 960;
  double cameraFrameLast = 960;

  Enemy(this.posx, this.posy, this.namefile) {
    // hitBox = Rect.fromLTWH(posx + 17, posy + (64 * (2 / 3)), 30, 64 / 3);
    componentx = AnimationComponent.sequenced(
      64.0,
      64.0,
      namefile,
      5,
      textureY: cameraFrame,
      textureWidth: 64.0,
      textureHeight: 64.0,
    );

    componentx.y = posy;
    componentx.x = posx;

    offset = Offset(posx, posy);
    bodyAngle = offset.direction;
    // tekst = "lt(${hitBox.left.toInt()},${hitBox.top.toInt()}) , rt(${(hitBox.left + hitBox.width).toInt()},${hitBox.top.toInt()} ) ,\n" +
    //     " lb(${hitBox.left.toInt()},${hitBox.top.toInt() + hitBox.height.toInt()}) , rb(${hitBox.left.toInt() + hitBox.width.toInt()},${hitBox.top.toInt() + hitBox.height.toInt()})";
  }

  void render(Canvas c) {
    // Paint bgPaint = Paint();
    // bgPaint.color = Color(0xff576574).withOpacity(0.9);
    // c.drawRect(hitBox, bgPaint);
    componentx.render(c);
    //TEXT
    TextSpan span =
        new TextSpan(style: new TextStyle(color: Colors.black), text: tekst);
    TextPainter tp = new TextPainter(
        text: span,
        textWidthBasis: TextWidthBasis.longestLine,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(c, new Offset(0.0, -20.0));
    //
    c.restore();
    c.save();
  }

  void update(double t) {
    componentx.animation.update(t);
    //  double targetBodyAngle = position.Player2.position.direction * 4;
    // final double rotationRate = pi * t;

    // if (targetBodyAngle != null) {
    //   if (bodyAngle < targetBodyAngle) {
    //     if ((targetBodyAngle - bodyAngle).abs() > pi) {
    //       bodyAngle = bodyAngle - rotationRate;
    //       if (bodyAngle < -pi) {
    //         bodyAngle += pi * 2;
    //       }
    //     } else {
    //       bodyAngle = bodyAngle + rotationRate;
    //       if (bodyAngle > targetBodyAngle) {
    //         bodyAngle = targetBodyAngle;
    //       }
    //     }
    //   }
    //   if (bodyAngle > targetBodyAngle) {
    //     if ((targetBodyAngle - bodyAngle).abs() > pi) {
    //       bodyAngle = bodyAngle + rotationRate;
    //       if (bodyAngle > pi) {
    //         bodyAngle -= pi * 2;
    //       }
    //     } else {
    //       bodyAngle = bodyAngle - rotationRate;
    //       if (bodyAngle < targetBodyAngle) {
    //         bodyAngle = targetBodyAngle;
    //       }
    //     }
    //   }
    // }

    if (position.Player2.position.dy < componentx.y - 10 &&
        position.Player2.position.dy < componentx.y + 10) {
      //componentx.x --;
      if ((componentx.y - 10 - position.Player2.position.dy).abs() < 20.0) {
      } else {
        componentx.y -= 0.5;
      }
    } else {
      // componentx.x++;
      if ((componentx.y - 10 - position.Player2.position.dy).abs() < 20.0) {
      } else {
        componentx.y += 0.5;
      }
    }

    if (position.Player2.position.dx < componentx.x - 10 &&
        position.Player2.position.dx < componentx.x + 10) {
      //componentx.x --;
      if ((componentx.x - 10 - position.Player2.position.dx).abs() < 20.0) {
            cameraFrame =832 ;
      } else {
        componentx.x -= 0.5;
        cameraFrame = 576;
      }
    } else {
      // componentx.x++;
      if ((componentx.x - 10 - position.Player2.position.dx).abs() < 20.0) {
        cameraFrame = 960;
      } else {
        // componentx = AnimationComponent.sequenced(
        //   64.0, 64.0, namefile, 9,
        //   textureY: 576, textureWidth: 64.0, textureHeight: 64.0);
        componentx.x += 0.5;
        cameraFrame = 704;
      }

     
    }

    if (cameraFrame == cameraFrameLast) {
    } else {
      componentxCopy = componentx;

      componentx = AnimationComponent.sequenced(64.0, 64.0, namefile, 6,
          textureY: cameraFrame, textureWidth: 64.0, textureHeight: 64.0);
      componentx.x = componentxCopy.x;
      componentx.y = componentxCopy.y;
      cameraFrameLast = cameraFrame;
    }
    // offset = offset + Offset.fromDirection(bodyAngle, 150 * t);

    // componentx.x-=t*50;
    // print("t ${componentx.y}");
  }
}
