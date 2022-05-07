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
  Map<String, int> results = {Player.playerO: 0, Player.playerX: 0};

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
        body: ListView(
          children: [_ResultAndBoard()],
        ));
  }

  Widget _ResultAndBoard() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints.expand(height: 100, width: 200),
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Player.playerO + ' VS ' + Player.playerX,
                        style: TextStyle(
                          fontSize: 30,
                        )),
                    Text('Player vs Player'),
                    Text(
                        results[Player.playerO].toString() +
                            " : " +
                            results[Player.playerX].toString(),
                        style: TextStyle(fontSize: 30)),
                  ]),
            )),
        Column(
            children: Utils.boxBuilder(
                board, (rowIndex, rowValue) => buildRow(rowIndex))),
      ],
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
            height: _setValueDueToOrientation(),
            width: _setValueDueToOrientation(),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(boxSize, boxSize), primary: color),
              child: Text(
                boxValue,
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () => selectField(boxValue, rowIndex, fieldIndex),
            )));
  }

  double _setValueDueToOrientation() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return 30.0;
    } else {
      return 35.0;
    }
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

      if (Utils.isWinner(rowIndex, fieldIndex, board, boardSize)) {
        showEndDialog('Player $currentMove Won');
        setState(() {
          results[currentMove] = results[currentMove] + 1;
        });
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
