import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final gearsFileName = 'assets/animgears.riv';
  final armFileName = 'assets/robot_arm.riv';
  Artboard _gearsArtboard, _armArtboard;
  RiveAnimationController _gearsController1, _gearsController2;
  List<RiveAnimationController> _gearsAnimControllers = [];
  int _gearsAnimIndex = 0;

  @override
  void initState() {
    _loadRiveFiles();
    super.initState();
  }

  // loads a Rive file
  void _loadRiveFiles() async {
    final bytes = await rootBundle.load(gearsFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      // Select an animation by its name

      setState(() => _gearsArtboard = file.mainArtboard
        ..addController(
          _gearsController1 = SimpleAnimation('spin2'),
        )
        ..addController(
          _gearsController2 = SimpleAnimation('spin1'),
        ));

      _gearsAnimControllers.add(_gearsController1);
      _gearsAnimControllers.add(_gearsController2);
    }

    // robot arm
    final armsBytes = await rootBundle.load(armFileName);
    final armFile = RiveFile();
    if(armFile.import(armsBytes)) {
      setState(() => _armArtboard = armFile.mainArtboard
        ..addController(SimpleAnimation('move'))
      );
    }
  }

  /// Show the rive file, when loaded
  @override
  Widget build(BuildContext context) {
    return _gearsArtboard != null ?
    Scaffold(
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _gearsAnimIndex = (_gearsAnimIndex + 1) % _gearsAnimControllers.length;
                for(int i = 0; i < _gearsAnimControllers.length; i++) {
                  _gearsAnimControllers[i].isActive = i == _gearsAnimIndex;
                }
              });
            },
            child: Container(
              height: 100,
              width: 100,
              child: Rive(
                useArtboardSize: false,
                artboard: _gearsArtboard,
                fit: BoxFit.contain,
              )
            )
          ),
          Container( // or SizedBox
              height: 150,
              width: 150,
              child: Rive(
                useArtboardSize: false,
                artboard: _armArtboard,
                fit: BoxFit.contain,
              )
          )

        ]
      )
    )
        :
    Container();
  }
}
