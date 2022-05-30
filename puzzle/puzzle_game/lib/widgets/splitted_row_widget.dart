import 'package:flutter/material.dart';

class SplittedRow extends StatefulWidget {
  final List<Image> splittedImage;
  final int start;
  final int end;
  final Map<String, bool> fittedImages;

  SplittedRow(
      {Key key,
      @required this.splittedImage,
      @required this.start,
      @required this.end,
      @required this.fittedImages})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplittedRowState();
  }
}

class _SplittedRowState extends State<SplittedRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          widget.splittedImage.sublist(widget.start, widget.end).map((piece) {
        return SizedBox(
            width: 128, height: 100, child: _buildDragTarget(piece));
      }).toList(),
    );
  }

  Widget _buildDragTarget(puzzle) {
    return DragTarget<Image>(
      builder: (BuildContext context, List<Image> incoming, List rejected) {
        if (widget.fittedImages[puzzle.semanticLabel] == true) {
          return Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
              ),
              child: Image(
                image: puzzle.image,
                fit: BoxFit.fill,
              ));
        } else {
          return Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
              ),
              child: Image(
                image: puzzle.image,
                fit: BoxFit.fill,
                color: Colors.grey,
                colorBlendMode: BlendMode.color,
              ));
        }
      },
      onWillAccept: (data) => data.semanticLabel == puzzle.semanticLabel,
      onAccept: (data) {
        setState(() {
          widget.fittedImages[puzzle.semanticLabel] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}
