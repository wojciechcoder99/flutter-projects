import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/split_image.dart';
import 'package:flutter_complete_guide/widgets/shuffled_pieces_widget.dart';
import 'package:flutter_complete_guide/widgets/splitted_row_widget.dart';

class Puzzle extends StatefulWidget {
  final int rows = 3;
  final int cols = 3;
  final String imagePath;

  Puzzle({this.imagePath});

  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  ByteData imageData;
  Uint8List list;
  List<Image> splittedImage = [];
  List<Image> shuffledImage = [];
  final Map<String, bool> fittedImages = {};
  final Map<String, bool> shuffledImages = {};

  initState() {
    super.initState();
    List<Image> helper;
    rootBundle.load(widget.imagePath).then((data) => setState(() => {
          helper = SplitImage.splitImage(data.buffer.asUint8List()),
          for (int i = 0; i < helper.length; i++)
            {
              splittedImage.add(Image(
                image: helper[i].image,
                semanticLabel: i.toString(),
              )),
              fittedImages[i.toString()] = false,
              shuffledImages[i.toString()] = false,
            },
          shuffledImage.addAll(splittedImage),
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (splittedImage == null || splittedImage.length == 0) {
      return Center(child: CircularProgressIndicator());
    }
    else {
      return Scaffold(
          appBar: AppBar(
              title: Text('Flutter Puzzle'), backgroundColor: Colors.pink),
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 400,
              child: Column(children: [
                SplittedRow(
                    splittedImage: splittedImage,
                    start: 0,
                    end: 3,
                    fittedImages: fittedImages),
                SplittedRow(
                    splittedImage: splittedImage,
                    start: 3,
                    end: 6,
                    fittedImages: fittedImages),
                SplittedRow(
                    splittedImage: splittedImage,
                    start: 6,
                    end: 9,
                    fittedImages: fittedImages),
                Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShuffledPieces(
                            shuffledImage: shuffledImage.sublist(0, 3), shuffledImages: shuffledImages
                          ),
                          ShuffledPieces(
                              shuffledImage: shuffledImage.sublist(3, 6), shuffledImages: shuffledImages,
                              hereShowEndSection: true,),
                          ShuffledPieces(
                              shuffledImage: shuffledImage.sublist(6, 9), shuffledImages: shuffledImages),
                        ]))
              ])));
    }
  }
}
