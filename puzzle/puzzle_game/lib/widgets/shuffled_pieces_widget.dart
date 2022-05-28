import 'dart:math';

import 'package:flutter/material.dart';

class ShuffledPieces extends StatefulWidget {
  final List<Image> shuffledImage;

  ShuffledPieces({
    @required this.shuffledImage
  });

  @override
  State<StatefulWidget> createState() {
    return _ShuffledPiecesState();
  }
}

class _ShuffledPiecesState extends State<ShuffledPieces> {
  int helpEnd;
  bool isDragCompleted = false;
  List<Image> imageList = [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (!isDragCompleted) {
        imageList = widget.shuffledImage;
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: imageList.map((puzzle) {
        return Draggable<Image>(
          data: Image(
              image: puzzle.image,
              fit: BoxFit.fill,
              color: Colors.grey,
              colorBlendMode: BlendMode.color,
              height: 150,
              width: 150,
              semanticLabel: puzzle.semanticLabel),
          child: Image(
            image: puzzle.image,
            fit: BoxFit.fill,
            height: 90,
            width: 125
          ),
          feedback: Image(
            image: puzzle.image,
            fit: BoxFit.fill,
            height: 90,
          ),
          childWhenDragging: Container(),
          onDragCompleted: () => {
                setState(() {
                  isDragCompleted = true;
                  imageList.removeWhere((element) =>
                      element.semanticLabel == puzzle.semanticLabel);
                })
              }
        );
      }).toList()
        ..shuffle(Random(0)),
    );
  }
}
