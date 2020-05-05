import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:nigtmin/Gamecontain.dart';

import 'Joypad.dart';
import 'MainGameLogick.dart';

Future main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);
  final size = await Flame.util.initialDimensions();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Title',
      home: new MyHomePage(size: size)));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.size}) : super(key: key);

  final String title;
  final Size size;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // GameMaps game = GameMaps(size: widget.size);
    MainLogick game = MainLogick();
    return Scaffold(
        body: Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          game.widget,
          Container(
            child: Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    SizedBox(width: 48),
                    Joypad(
                      onChange: game.onLeftJoypadChange,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTapDown: (_) => game.onHit(true),
                      onTapUp: (_) => game.onHit(false),
                      child: Container(
                        // onPressed: () {
                        //   // game.onHit();
                        // },
                        // elevation: 2.0,
                        // fillColor: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
                        child: Image.asset(
                          'assets/images/hit.png',
                          width: 20,
                        ),
                        padding: EdgeInsets.all(15.0),
                        // shape: CircleBorder(),
                      ),
                    ),
                    SizedBox(width: 28),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
