import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(TicTacToeGame());
}

class TicTacToeGame extends StatelessWidget {
  final String title = "Tic Tac Toe";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primaryColor: Colors.blue),
      home: MainPage(title: title),
    );
  }
}

class Player {
  static const String playerNone = '';
  static const String playerX = 'X';
  static const String playerO = 'O';
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final int boardSize = 5;
  static final double boxSize = 50;

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
        margin: EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(boxSize, boxSize), primary: color),
          child: Text(boxValue, style: TextStyle(fontSize: 30)),
          onPressed: () => selectField(boxValue, rowIndex, fieldIndex),
        ));
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
