import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/start-menu.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(TicTacToeGame());
}

class TicTacToeGame extends StatelessWidget {
  final String title = "Tic Tac Toe";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primaryColor: Colors.blue),
      home: StartMenu(title: title),
    );
  }
}

