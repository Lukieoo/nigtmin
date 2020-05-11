import 'dart:ui';
import 'dart:math';
import 'package:flame/components/animation_component.dart';
import 'package:flutter/material.dart';
import 'MainGameLogick.dart';
import 'MainGameLogick.dart' as global;

class Player2 {
  final MainLogick game;
  static Offset position = Offset.zero;
  double bodyAngle = 0;
  double turretAngle = 0;
  double targetBodyAngle;
  double targetTurretAngle;

  double cameraFrame = 0;
  double cameraFrameLast = 0;
  AnimationComponent component;
  double positionLast = 1;
  int amount = 3;
  double width = 0;
  double height = 0;

  Offset posYoyPad = Offset.zero;

  bool isFight = false;
  bool isEndMap = false;
  bool wasFighting = false;
  Rect hitBox;
  double boxSize = 96.0;
  bool blockColiser = false;
  String tekst = "debug";

  Player2(this.game, this.width, this.height) {
    position = Offset(
      width / 2 - 46,
      height / 2 - 46,
    );

    component = AnimationComponent.sequenced(
      96.0,
      96.0,
      'minotaur.png',
      5,
      textureY: 0,
      textureWidth: 96.0,
      textureHeight: 96.0,
    );

    component.y = 200;
    component.x = 100;
  }

  Future<void> onHit(bool heHit) async {
    if (heHit) {
      //RIGHT Site
      if (posYoyPad.dx.toInt() > 0) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 576, textureWidth: 96.0, textureHeight: 96.0);
      }
      //LEFT Site
      else if (posYoyPad.dx.toInt() < 0) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 1536, textureWidth: 96.0, textureHeight: 96.0);
      }
      //WHEN UP in 90
      if (posYoyPad.dx.toInt() == 0 && posYoyPad.dy.toInt() != 0) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 1536, textureWidth: 96.0, textureHeight: 96.0);
      }

      //Site POSITION RIGHT
      if (posYoyPad.dx.toInt() == 0 &&
          (cameraFrameLast.toInt() == 96 ||
              cameraFrameLast.toInt() == 480 ||
              cameraFrameLast.toInt() == 0)) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 576, textureWidth: 96.0, textureHeight: 96.0);

        //Site POSITION LEFT
      } else if (posYoyPad.dx.toInt() == 0 &&
          (cameraFrameLast.toInt() == 1056 ||
              cameraFrameLast.toInt() == 1440)) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 1536, textureWidth: 96.0, textureHeight: 96.0);
      }

      component.y = position.dy;
      component.x = position.dx;

      isFight = true;
    } else {
      isFight = false;
      wasFighting = true;
    }
  }

  void render(Canvas c) {
    component.render(c);
    c.rotate(turretAngle);

    hitBox = Rect.fromLTWH(30, 20, 35, 45);
    hitBox = Rect.fromLTWH(32, 96 * 1 / 3, 30, 96 / 4);

    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574).withOpacity(0.0);

    //TEXT
    // TextSpan span = new TextSpan(
    //     style: new TextStyle(color: Colors.blue[800]), text: tekst);
    // TextPainter tp = new TextPainter(
    //     text: span,
    //     textAlign: TextAlign.left,
    //     textDirection: TextDirection.ltr);

    // tp.layout();
    // tp.paint(c, new Offset(5.0, 5.0));
    // //
    c.drawRect(hitBox, bgPaint);
    c.restore();
    c.save();
    // c.rotate(bodyAngle);
  }

  void update(double t) {
    component.animation.update(t);
    //hitBox = hitBox.translate(0,t);

    if (!isFight) {
      final double rotationRate = pi * t;

      if (targetBodyAngle != null) {
        if (bodyAngle < targetBodyAngle) {
          if ((targetBodyAngle - bodyAngle).abs() > pi) {
            bodyAngle = bodyAngle - rotationRate;
            if (bodyAngle < -pi) {
              bodyAngle += pi * 2;
            }
          } else {
            bodyAngle = bodyAngle + rotationRate;
            if (bodyAngle > targetBodyAngle) {
              bodyAngle = targetBodyAngle;
            }
          }
        }
        if (bodyAngle > targetBodyAngle) {
          if ((targetBodyAngle - bodyAngle).abs() > pi) {
            bodyAngle = bodyAngle + rotationRate;
            if (bodyAngle > pi) {
              bodyAngle -= pi * 2;
            }
          } else {
            bodyAngle = bodyAngle - rotationRate;
            if (bodyAngle < targetBodyAngle) {
              bodyAngle = targetBodyAngle;
            }
          }
        }
      }
blockColiser = false;
      for (var block in global.MainLogick.block) {
        

        ///COLISER BOX

        if (bodyAngle == targetBodyAngle) {

          
          if (block.left + block.width >
                  (position + Offset.fromDirection(bodyAngle, 150 * t)).dx +
                      hitBox.left &&
              block.left <
                  (position + Offset.fromDirection(bodyAngle, 150 * t)).dx +
                      hitBox.left +
                      hitBox.width &&
              block.top + block.height >
                  (position + Offset.fromDirection(bodyAngle, 150 * t)).dy +
                      hitBox.top &&
              block.top <
                  (position + Offset.fromDirection(bodyAngle, 150 * t)).dy +
                      hitBox.height +
                      hitBox.top) {
            blockColiser = true;
            tekst = "speed B ${block.left}";
            position = position +
                Offset(Offset.fromDirection(bodyAngle, 150 * t).dx, 0);
          }
       
        } else {
          if (targetBodyAngle == null) {
          } else {
            ///TAG start
            if (block.left + block.width >
                    (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                            .dx +
                        hitBox.left &&
                block.left <
                    (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                            .dx +
                        hitBox.left +
                        hitBox.width &&
                block.top + block.height >
                    (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                            .dy +
                        hitBox.top &&
                block.top <
                    (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                            .dy +
                        hitBox.height +
                        hitBox.top) {
              blockColiser = true;

              tekst = "speed T ${block.left}";
              position = position +
                  Offset(Offset.fromDirection(targetBodyAngle, 150 * t).dx, 0);
            }
          
          }
        }

        
      }
      if (blockColiser) {
      } else {
        //  tekst = "else ";

        if (bodyAngle == targetBodyAngle) {
          if (-hitBox.top >
                  (position + Offset.fromDirection(bodyAngle, 150 * t)).dy ||
              height - hitBox.bottom <
                  (position + Offset.fromDirection(bodyAngle, 150 * t)).dy ||
              -hitBox.left >
                  (position + Offset.fromDirection(bodyAngle, 150 * t)).dx ||
              width - hitBox.right <
                  (position + Offset.fromDirection(bodyAngle, 150 * t)).dx) {
            //Moving hibox hit

            if (-hitBox.left >
                        (position + Offset.fromDirection(bodyAngle, 150 * t))
                            .dx &&
                    -hitBox.top >
                        (position + Offset.fromDirection(bodyAngle, 150 * t))
                            .dy ||
                -hitBox.left >
                        (position + Offset.fromDirection(bodyAngle, 150 * t))
                            .dx &&
                    height - hitBox.bottom <
                        (position + Offset.fromDirection(bodyAngle, 150 * t))
                            .dy ||
                width - hitBox.right <
                        (position + Offset.fromDirection(bodyAngle, 150 * t))
                            .dx &&
                    -hitBox.top >
                        (position + Offset.fromDirection(bodyAngle, 150 * t))
                            .dy ||
                width - hitBox.right <
                        (position + Offset.fromDirection(bodyAngle, 150 * t))
                            .dx &&
                    height - hitBox.bottom <
                        (position + Offset.fromDirection(bodyAngle, 150 * t))
                            .dy) {
              // print("DZIEJE SIE");
            } else {
              if (-hitBox.top >
                      (position + Offset.fromDirection(bodyAngle, 150 * t))
                          .dy ||
                  height - hitBox.bottom <
                      (position + Offset.fromDirection(bodyAngle, 150 * t))
                          .dy) {
                position = position +
                    Offset(Offset.fromDirection(bodyAngle, 150 * t).dx, 0);
              }
              if (-hitBox.left >
                      (position + Offset.fromDirection(bodyAngle, 150 * t))
                          .dx ||
                  width - hitBox.right <
                      (position + Offset.fromDirection(bodyAngle, 150 * t))
                          .dx) {
                position = position +
                    Offset(0, Offset.fromDirection(bodyAngle, 150 * t).dy);
              }
            }

            //END Moving hibox hit

          } else {
            Offset.fromDirection(
              bodyAngle,
            );
            position = position + Offset.fromDirection(bodyAngle, 150 * t);
          }

          // print("bodyAngle $targetBodyAngle");
        } else {
          if (targetBodyAngle == null) {
          } else {
            if (-hitBox.top >
                    (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                        .dy ||
                height - hitBox.bottom <
                    (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                        .dy ||
                -hitBox.left >
                    (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                        .dx ||
                width - hitBox.right <
                    (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                        .dx) {
              //Moving hibox hit

              if (-hitBox.left >
                          (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                              .dx &&
                      -hitBox.top >
                          (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                              .dy ||
                  -hitBox.left >
                          (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                              .dx &&
                      height - hitBox.bottom <
                          (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                              .dy ||
                  width - hitBox.right <
                          (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                              .dx &&
                      -hitBox.top >
                          (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                              .dy ||
                  width - hitBox.right <
                          (position + Offset.fromDirection(targetBodyAngle, 150 * t))
                              .dx &&
                      height - hitBox.bottom <
                          (position +
                                  Offset.fromDirection(targetBodyAngle, 150 * t))
                              .dy) {
                // print("DZIEJE SIE");
              } else {
                if (-hitBox.top >
                        (position +
                                Offset.fromDirection(targetBodyAngle, 150 * t))
                            .dy ||
                    height - hitBox.bottom <
                        (position +
                                Offset.fromDirection(targetBodyAngle, 150 * t))
                            .dy) {
                  position = position +
                      Offset(
                          Offset.fromDirection(targetBodyAngle, 150 * t).dx, 0);
                }
                if (-hitBox.left >
                        (position +
                                Offset.fromDirection(targetBodyAngle, 150 * t))
                            .dx ||
                    width - hitBox.right <
                        (position +
                                Offset.fromDirection(targetBodyAngle, 150 * t))
                            .dx) {
                  position = position +
                      Offset(
                          0, Offset.fromDirection(targetBodyAngle, 150 * t).dy);
                }
              }

              //END Moving hibox hit

            } else {
              position =
                  position + Offset.fromDirection(targetBodyAngle, 150 * t);
            }
          }
        }
      }
      // print("HitBox r ${hitBox.right}");
      // print("HitBox t ${hitBox.top}");
      // print("HitBox b ${hitBox.bottom}");
      // print("HitBox l ${hitBox.left}");
      // print("position ${position.dx}  ${position.dy}");
      component.x = position.dx;
      component.y = position.dy;

      //Set Player Position

      //RIGHT
      if (posYoyPad.dx.toInt() > 0) {
        cameraFrame = 96.0;
        amount = 8;
      }
      //LEFT
      else if (posYoyPad.dx.toInt() < 0) {
        cameraFrame = 1056;
        amount = 8;
      }
      //LAST POSITION RIGHT
      if (posYoyPad.dx.toInt() == 0 && cameraFrameLast.toInt() == 96) {
        cameraFrame = 480;
        amount = 6;

        //LAST POSITION LEFT
      } else if (posYoyPad.dx.toInt() == 0 && cameraFrameLast.toInt() == 1056) {
        cameraFrame = 1440;
        amount = 6;
      }
      //WHEN UP in 90
      if (posYoyPad.dx.toInt() == 0 && posYoyPad.dy.toInt() != 0) {
        cameraFrame = 1056;
        amount = 8;
      }

      if (cameraFrameLast == cameraFrame && !wasFighting) {
      } else {
        component = AnimationComponent.sequenced(
            96.0, 96.0, 'minotaur.png', amount,
            textureY: cameraFrame, textureWidth: 96.0, textureHeight: 96.0);

        component.x = position.dx;
        component.y = position.dy;

        cameraFrameLast = cameraFrame;

        wasFighting = false;
      }
    }
  }
}
