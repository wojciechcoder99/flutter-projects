import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/puzzle.dart';
import 'package:flutter_complete_guide/utils/images_path.dart';
import 'package:flutter_complete_guide/widgets/shuffled_pieces_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should find option button', (WidgetTester tester) async {
    final BuildContext context = tester.element(find.byType(Container));

    await tester.pumpWidget(ElevatedButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => new Puzzle()));
      },
      child: Image.asset(
        ImagesPath.IMAGE_ONE,
        fit: BoxFit.fill,
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
      ),
    ));

    final button = find.byKey(Key('menu-image-button'));

    expect(button, findsWidgets);
  });

  testWidgets('Should find shuffled widget', (WidgetTester tester) async {
    List<Image> shuffledImage = [
      Image(image: Image.asset(ImagesPath.IMAGE_EIGHT).image,), 
      Image(image: Image.asset(ImagesPath.IMAGE_FIVE).image,), 
      Image(image: Image.asset(ImagesPath.IMAGE_FOUR).image,)
      ];

    final Map<String, bool> shuffledImages = {};

    await tester.pumpWidget(ShuffledPieces(
      shuffledImage: shuffledImage.sublist(0, 3), 
      shuffledImages: shuffledImages));

    final widget = find.byElementType(ShuffledPieces);

    expect(widget, findsWidgets);
  });
}
