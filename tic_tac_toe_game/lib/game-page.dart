import 'package:flutter/material.dart';

import 'utils.dart';

class Player {
  static const String playerNone = '';
  static const String playerX = 'X';
  static const String playerO = 'O';
}

class GamePage extends StatefulWidget {
  final String title;

  const GamePage({
    @required this.title,
  });

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static final int boardSize = 10;
  static final double boxSize = 5;

  List<List<String>> board;
  String previousMove = Player.playerNone;

  @override
  void initState() {
    super.initState();
    setEmptyFields();
  }

  void setEmptyFields() {
    setState(() {
      board = List.generate(
          boardSize, (_) => List.generate(boardSize, (_) => Player.playerNone));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getBackgroundColor(),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Utils.boxBuilder(
              board, (rowIndex, rowValue) => buildRow(rowIndex)),
        ));
  }

  Color getBackgroundColor() {
    final nextMove =
        previousMove == Player.playerO ? Player.playerX : Player.playerO;
    return getFieldColor(nextMove).withAlpha(150);
  }

  buildRow(int rowIndex) {
    final row = board[rowIndex];
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Utils.boxBuilder(
            row, (fieldIndex, boxValue) => buildField(rowIndex, fieldIndex)));
  }

  Widget buildField(int rowIndex, int fieldIndex) {
    final boxValue = board[rowIndex][fieldIndex];
    final color = getFieldColor(boxValue);

    return Container(
        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 35,
          width: 35,
          child:ElevatedButton(
          style: ElevatedButton.styleFrom(
           fixedSize: Size(boxSize, boxSize), primary: color),
          child: Text(boxValue, style: TextStyle(fontSize: 25), ),
          onPressed: () => selectField(boxValue, rowIndex, fieldIndex),
        )));
  }

  getFieldColor(String boxValue) {
    switch (boxValue) {
      case Player.playerO:
        return Colors.red;
      case Player.playerX:
        return Colors.green;
      default:
        return Colors.white;
    }
  }

  selectField(String boxValue, int rowIndex, int fieldIndex) {
    if (boxValue == Player.playerNone) {
      final currentMove =
          previousMove == Player.playerX ? Player.playerO : Player.playerX;

      setState(() {
        previousMove = currentMove;
        board[rowIndex][fieldIndex] = currentMove;
      });

      if (Utils.isWinner(rowIndex, fieldIndex, board, 5)) {
        showEndDialog('Player $currentMove Won');
      } else if (isEnd()) {
        showEndDialog('A Draw! Try again!');
      }
    }
  }

  Future showEndDialog(String title) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text('Press to Restart the Game'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setEmptyFields();
                      Navigator.of(context).pop();
                    },
                    child: Text('Restart'))
              ],
            ));
  }

  bool isEnd() {
    return board
        .every((row) => row.every((field) => field != Player.playerNone));
  }
}
