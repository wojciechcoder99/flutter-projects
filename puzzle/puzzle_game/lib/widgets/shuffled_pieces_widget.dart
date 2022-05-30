import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ShuffledPieces extends StatefulWidget {
  final List<Image> shuffledImage;
  final Map<String, bool> shuffledImages;
  final hereShowEndSection;

  ShuffledPieces(
      {@required this.shuffledImage,
      @required this.shuffledImages,
      this.hereShowEndSection});

  @override
  State<StatefulWidget> createState() {
    return _ShuffledPiecesState();
  }
}

class _ShuffledPiecesState extends State<ShuffledPieces> {
  int helpEnd;
  bool isDragCompleted = false;
  List<Image> imageList = [];
  Stopwatch watch = Stopwatch();
  Timer timer;

  String elapsedTime = '';

  initState() {
    super.initState();
    startWatch();
  }

  startWatch() {
    setState(() {
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (!isDragCompleted) {
        imageList = widget.shuffledImage;
      }
    });
    if (widget.shuffledImages.values.every((element) => element == true) &&
        widget.hereShowEndSection != null &&
        widget.hereShowEndSection == true) {
      widget.shuffledImages.clear();
      stopWatch();
      return Align(
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: Colors.pink 
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    child: SizedBox(
                        width: 80,
                        height: 80,
                        child: ElevatedButton(
                            child: Icon(
                              Icons.home_filled,
                              size: 50,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }))),
                Text('Needed time: $elapsedTime min', style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            )),
          ));
    }
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
                image: puzzle.image, fit: BoxFit.fill, height: 90, width: 125),
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
                    widget.shuffledImages[puzzle.semanticLabel] = true;
                  })
                });
      }).toList()
        ..shuffle(Random(0)),
    );
  }
}
