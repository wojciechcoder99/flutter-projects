import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../view-model/game-controller.vm.dart';

class RankingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RankingPage();
  }
}

class _RankingPage extends State<RankingPage> {
  GameController gameController;
  List<String> values;

  @override
  void initState() {
    super.initState();
    gameController = Get.put(GameController(true));
    fillList();
  }

  Future<void> fillList() async {
    String data = await gameController.convertOutputFile();
    setState(() {
      values = data.split('\\');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: ListView(
          children: [_getListWidgets()],
        ));
  }

  Widget _getListWidgets() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: values
            .map((line) => Row(children: [
                  _createResultWidget(Icons.close, Colors.blue,
                      line.split('|')[2], Constants.WIN_LABEL),
                  _createResultWidget(Icons.circle_outlined, Colors.pink,
                      line.split('|')[4], Constants.WIN_LABEL),
                  _createResultWidget(Icons.scale_sharp, Colors.grey,
                      line.split('|')[6], Constants.DRAW_LABEL),
                ]))
            .toList());
  }

  Widget _createResultWidget(
      IconData icon, MaterialColor color, String player, String value) {
    return Column(children: [
      Icon(icon, color: color, size: 60.0),
      Text(player + Constants.SPACE + value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ]);
  }
}
