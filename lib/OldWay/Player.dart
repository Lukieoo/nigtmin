import 'dart:ui';
import 'dart:math';
import 'package:flame/components/animation_component.dart';
 

import 'Gamecontain.dart';

class Player {
  final GameMaps game;
  Offset position = Offset.zero;
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
  bool wasFighting = false;

  Player(this.game, this.width, this.height) {
    position = Offset(
      width,
      height,
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
    
    game.add(component
      ..y = height
      ..x = width);
  }
  Future<void> onHit(bool heHit) async {
    if (heHit) {
      //RIGHT Site
      if (posYoyPad.dx.toInt() > 0) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 576, textureWidth: 96.0, textureHeight: 96.0);
        game.components.clear();
      }
      //LEFT Site
      else if (posYoyPad.dx.toInt() < 0) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 1536, textureWidth: 96.0, textureHeight: 96.0);
        game.components.clear();
      }

      //Site POSITION RIGHT
      if (posYoyPad.dx.toInt() == 0 &&
          (cameraFrameLast.toInt() == 96 ||
              cameraFrameLast.toInt() == 480 ||
              cameraFrameLast.toInt() == 0)) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 576, textureWidth: 96.0, textureHeight: 96.0);
        game.components.clear();

        //Site POSITION LEFT
      } else if (posYoyPad.dx.toInt() == 0 &&
          (cameraFrameLast.toInt() == 1056 ||
              cameraFrameLast.toInt() == 1440)) {
        component = AnimationComponent.sequenced(96.0, 96.0, 'minotaur.png', 9,
            textureY: 1536, textureWidth: 96.0, textureHeight: 96.0);
        game.components.clear();
      }
     
      game.add(component
        ..y = position.dy
        ..x = position.dx);
      isFight = true;
    } else {
      isFight = false;
      wasFighting = true;
    }
  }

  void render(Canvas c) {
    c.rotate(turretAngle);
    // c.rotate(bodyAngle);
  }

  void update(double t) {
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

      if (bodyAngle == targetBodyAngle) {
        position = position + Offset.fromDirection(bodyAngle, 150 * t);
        // print("bodyAngle $targetBodyAngle");
      } else {
        if (targetBodyAngle == null) {
        } else {
          position = position + Offset.fromDirection(targetBodyAngle, 150 * t);
        }
      }

      //Set Player Position
      component.x = position.dx;
      component.y = position.dy;

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

      if (cameraFrameLast == cameraFrame && !wasFighting) {
      } else {
        component = AnimationComponent.sequenced(
            96.0, 96.0, 'minotaur.png', amount,
            textureY: cameraFrame, textureWidth: 96.0, textureHeight: 96.0);

        game.components.clear();
        
    
        game.add(component
          ..y = position.dy
          ..x = position.dx);
        cameraFrameLast = cameraFrame;

        wasFighting = false;
      }
    }
  }
}
