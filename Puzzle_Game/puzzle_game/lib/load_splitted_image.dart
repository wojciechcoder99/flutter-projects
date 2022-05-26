import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/split_image.dart';

class Puzzle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Puzzle();
  }

}

class _Puzzle extends State<Puzzle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: SplitImage.splitImage('puzzle_1.jpg').map((e) => new Container(
        child: e),
        ).toList()
    );
  }

}