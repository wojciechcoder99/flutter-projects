import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;

class SplitImage {
  static List<Image> splitImage(List<int> input) {
    imglib.Image image = imglib.decodeImage(input);

    int x = 0, y = 0;
    int width = (image.width / 3).round();
    int height = (image.height / 4).round();

    // split image to parts
    List<imglib.Image> parts = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        parts.add(imglib.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }

    // convert image from image package to Image Widget to display
    List<Image> output = [];
    for (var img in parts) {
      output.add(Image.memory(imglib.encodeJpg(img)));
    }

    return output;
  }
}
