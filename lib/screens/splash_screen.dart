import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final riveFileName = 'assets/pulsingheart.riv';
  Artboard _artboard;

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

      setState(
        () => _artboard = file.mainArtboard
          ..addController(
            SimpleAnimation('pulse'),
          )
      );

    }
    Future.delayed(Duration(seconds: 4)).then((value) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen())
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _artboard != null ?
      Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter + Flare', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
            Container( // or SizedBox
              height: 150,
              width: 150,
              child: Rive(
                useArtboardSize: false,
                artboard: _artboard,
                fit: BoxFit.contain,
              )
            )
          ],
        ),
      )
      :
      Container();
  }
}

