import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    print('heart pulse v1');
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

