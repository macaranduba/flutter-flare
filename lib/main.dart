import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyRiveAnimation(),
    );
  }
}

class MyRiveAnimation extends StatefulWidget {
  @override
  _MyRiveAnimationState createState() => _MyRiveAnimationState();
}

class _MyRiveAnimationState extends State<MyRiveAnimation> {
  final riveFileName = 'assets/animgears.riv';
  Artboard _artboard;
  RiveAnimationController _controller1, _controller2;
  List<RiveAnimationController> _animationsControllers = [];
  int _animationIndex = 0;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  // loads a Rive file
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      // Select an animation by its name
/*
      setState(
        () => _artboard = file.mainArtboard
          ..addController(
            _controller1 = SimpleAnimation('spin1'),
          )
          ..addController(
            _controller2 = SimpleAnimation('spin2'),
          )
      );
*/
      setState(
        () {
          _artboard = file.mainArtboard;
          file.mainArtboard.addController(
            _controller1 = SimpleAnimation('spin1')
          );
          file.mainArtboard.addController(
            _controller2 = SimpleAnimation('spin2')
          );
        }
      );

      _animationsControllers.add(_controller1);
      _animationsControllers.add(_controller2);
    }
  }

  /// Show the rive file, when loaded
  @override
  Widget build(BuildContext context) {
    return _artboard != null ?
      Scaffold(
        body: Center (
          child: GestureDetector(
            onTap: () {
              setState(() {
                _animationIndex = (_animationIndex + 1) % 2;
                for(int i = 0; i < _animationsControllers.length; i++) {
                  _animationsControllers[i].isActive = i == _animationIndex;
                  print('> _animationsControllers[$i].isActive = ${i == _animationIndex}');
                }
              });
            },
            child: Container(
              height: 100,
              width: 100,
              child: Rive(
                useArtboardSize: false,
                artboard: _artboard,
                fit: BoxFit.contain,
              )
            )
          )
        )

      )
      :
      Container();
  }
}
