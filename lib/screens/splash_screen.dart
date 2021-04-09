import 'package:flare_test/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final riveFileName = 'assets/animgears.riv';
  Artboard _artboard;
  //RiveAnimationController _controller1, _controller2;
  //List<RiveAnimationController> _animationsControllers = [];
  //int _animationIndex = 0;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();

    Future.delayed(Duration(seconds: 4)).then((value) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen())
      )
    );
  }

  // loads a Rive file
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      // Select an animation by its name

      setState(
              () => _artboard = file.mainArtboard
            ..addController(
              /*controller1 =*/ SimpleAnimation('spin1'),
            )
        /*..addController(
            _controller2 = SimpleAnimation('spin2'),
          )*/
      );

      /*_animationsControllers.add(_controller1);
      _animationsControllers.add(_controller2);*/
    }
    print('v2');
  }

  /// Show the rive file, when loaded
  @override
  Widget build(BuildContext context) {
    return _artboard != null ?
    Scaffold(
        body: Center (
            child: Container(
                height: 150,
                width: 150,
                child: Rive(
                  useArtboardSize: false,
                  artboard: _artboard,
                  fit: BoxFit.contain,
                )
            )
        )
    )
        :
    Container();
  }
}
