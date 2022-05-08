import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/view-model/constants.dart';
import 'package:get/get.dart';

import '../model/player.model.dart';
import '../utils.dart';
import '../view-model/game-controller.vm.dart';

class GamePage extends StatefulWidget {
  final String title;

  const GamePage({
    @required this.title,
  });

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  final gameController = Get.put(GameController());

  @override
  void initState() {
    super.initState();
    gameController.setEmptyFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
            constraints: BoxConstraints.expand(
                height: 120, width: MediaQuery.of(context).size.width),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Container(
                  child: Container(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 50.0, top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _createResultWidget(Icons.close, Colors.blue,
                                Player.playerX, Constants.WIN_LABEL),
                            _createResultWidget(
                                Icons.circle_outlined,
                                Colors.pink,
                                Player.playerX,
                                Constants.WIN_LABEL),
                            _createResultWidget(Icons.scale_sharp, Colors.grey,
                                Constants.DRAW_LABEL, Constants.DRAW_LABEL),
                          ]))),
            )),
        Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: Utils.boxBuilder(
                gameController.board, (rowIndex, rowValue) => buildRow(rowIndex)))),
        Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _setCurrentMovePlayerIcon(),
                Text(gameController.nextMoveText())
              ],
            )),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _createCircleOptionButton(Icons.restart_alt_sharp, () {}),
          _createCircleOptionButton(Icons.home_filled, () {}),
        ])
      ],
    ));
  }

  Widget _createResultWidget(
      IconData icon, MaterialColor color, String player, String label) {
    return Column(children: [
      Icon(icon, color: color, size: 60.0),
      Text(gameController.results[player].toString() + Constants.SPACE + label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _createCircleOptionButton(IconData icon, Function onPressed) {
    return Container(
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        width: 100.0,
        height: 60.0,
        child: ElevatedButton(
          child: Icon(icon, color: Colors.white, size: 50.0),
          onPressed: onPressed,
        ));
  }

  // ignore: missing_return
  Widget _setCurrentMovePlayerIcon() {
    switch (gameController.setCurrentMovePlayer()) {
      case Player.playerO:
        return Icon(Icons.circle_outlined, color: Colors.pink, size: 40.0);
      case Player.playerX:
        return Icon(Icons.close, color: Colors.blue, size: 40.0);
    }
  }

  buildRow(int rowIndex) {
    final row = gameController.board[rowIndex];
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Utils.boxBuilder(
            row, (fieldIndex, boxValue) => buildField(rowIndex, fieldIndex)));
  }

  Widget buildField(int rowIndex, int fieldIndex) {
    final boxValue = gameController.board[rowIndex][fieldIndex];
    final color = gameController.getFieldColor(boxValue.value);

    return Container(
        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.zero,
        child: SizedBox(
            height: _setValueDueToOrientation(),
            width: _setValueDueToOrientation(),
            child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(GameController.boxSize, GameController.boxSize), primary: color),
              child: Container(
                  child: Center(
                      child: Text(
                boxValue.value,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ))),
              onPressed: () => gameController.selectField(boxValue.value, rowIndex, fieldIndex)),
            ));
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
                      gameController.setEmptyFields();
                      Navigator.of(context).pop();
                    },
                    child: Text('Restart'))
              ],
            ));
  }

    double _setValueDueToOrientation() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return 30.0;
    } else {
      return 35.0;
    }
  }
}
