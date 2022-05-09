import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/model/player.model.dart';
import 'package:flutter_complete_guide/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('Should find result widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      Icon(Icons.close, color: Colors.blue, size: 60.0, textDirection: TextDirection.ltr,),);

    final iconFinder = find.byIcon(Icons.close);

    expect(iconFinder, findsWidgets);
  });
}