import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../view-model/game-controller.vm.dart';
import 'menu-page.view.dart';

class RankingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RankingPage();
  }
}

class _RankingPage extends State<RankingPage> {
  GameController gameController;
  List<String> values = <String>[].obs;
  //  = List.of(['2022-05-10|X|1|O|0|Draw|0','2022-05-10|X|1|O|0|Draw|0','2022-05-10|X|1|O|0|Draw|0']);

  _RankingPage() {
    gameController = Get.put(GameController(true));
    gameController.convertOutputFile().then((value) => setState(() {
          values = value.split('\\');
          values.remove(Constants.EMPTY_STRING);
          values.sort((a, b) =>
              int.parse(a.split('|')[2]).compareTo(int.parse(b.split('|')[2])));
          values = values.reversed.toList();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => getBackAndDeleteController(context)),),
        body: ListView(
          children: [_getListWidgets()],
        ));
  }

  Future<dynamic> getBackAndDeleteController(BuildContext context) {
    Get.delete<GameController>();
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => MenuPage(title: 'Tic Tac Toe')));
  }

  // ignore: missing_return 
  Widget _getListWidgets() {
    return Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: values
            .map((line) => Container(
                padding: EdgeInsets.only(left: 10.0, right: 20.0, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children:[
                        Text(line.split('|')[0] + ' -> ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(line.split('|')[7], style: TextStyle(fontWeight: FontWeight.bold))]),
                      _createResultWidget(Icons.close, Colors.blue,
                          line.split('|')[2], Constants.WIN_LABEL),
                      _createResultWidget(Icons.circle_outlined, Colors.pink,
                          line.split('|')[4], Constants.WIN_LABEL),
                      _createResultWidget(Icons.scale_sharp, Colors.grey,
                          line.split('|')[6], Constants.DRAW_LABEL),
                    ])))
            .toList()));
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
