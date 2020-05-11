  
import 'package:flame/components/component.dart'; 
import 'package:flame/components/tiled_component.dart';
import 'package:flutter/material.dart';



class Mapx extends Component {
 
  final TiledComponent tiledMap = TiledComponent('arena.tmx');
  void render(Canvas c) {
    tiledMap.render(c);
  
  }

  void update(double t) {
        
  }
 
 


}