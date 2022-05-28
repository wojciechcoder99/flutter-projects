import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/choice_menu_widget.dart';
import 'package:flutter_complete_guide/widgets/shuffled_pieces_widget.dart';
import 'package:flutter_complete_guide/widgets/splitted_row_widget.dart';
import 'package:flutter_complete_guide/split_image.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Puzzle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChoiceMenu(),
    );
  }
}

