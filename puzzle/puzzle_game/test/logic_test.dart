import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/puzzle.dart';
import 'package:flutter_complete_guide/utils/images_path.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('Should divide image into 9 parts', () {
    // given
    List<Image> splittedImage = [];
    // when
    var puzzle = new Puzzle(
      imagePath: ImagesPath.IMAGE_ONE,
      splittedImage: splittedImage,
    );
    // then
    expect(puzzle.splittedImage.length, 0);
  });

  test('Should init fitted list with false values', () {
    // given
    Map<String, bool> fittedImages = {};
    // when
    var puzzle = new Puzzle(
      imagePath: ImagesPath.IMAGE_ONE,
      helperFittedMap: fittedImages,
    );
    // then
    puzzle.helperFittedMap.values.forEach((element) {
      expect(element, false);
    });
  });

  test('Should contain 3 puzzles', () {
    // given
    // when
    // then
  });
}
