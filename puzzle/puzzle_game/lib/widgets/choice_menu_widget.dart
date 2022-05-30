import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/puzzle.dart';
import 'package:flutter_complete_guide/utils/images_path.dart';
import 'package:flutter_complete_guide/widgets/menu_option.dart';

class ChoiceMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Text('Flutter Puzzle'), backgroundColor: Colors.pink),
      body: Center(
        child: ListView(
        children: [Column(
          children: [
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_ONE,), imagePath: ImagesPath.IMAGE_ONE),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_TWO,), imagePath: ImagesPath.IMAGE_TWO),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_THREE,), imagePath: ImagesPath.IMAGE_THREE),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_FOUR,), imagePath: ImagesPath.IMAGE_FOUR),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_FIVE,), imagePath: ImagesPath.IMAGE_FIVE),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_SIX,), imagePath: ImagesPath.IMAGE_SIX),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_SEVEN,), imagePath: ImagesPath.IMAGE_SEVEN),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_EIGHT,), imagePath: ImagesPath.IMAGE_EIGHT),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_NINE,), imagePath: ImagesPath.IMAGE_NINE),
            MenuOption(Puzzle: new Puzzle(imagePath: ImagesPath.IMAGE_TEN,), imagePath: ImagesPath.IMAGE_TEN),
      ],
    )])));
  }
}
