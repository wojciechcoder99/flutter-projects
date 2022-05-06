import 'package:flutter/material.dart';

import 'game-page.dart';

class StartMenu extends StatelessWidget {
  final String title;
  const StartMenu({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints.expand(height: 200, width: 200),
                child: Container(
                  child: ElevatedButton(
                    child: Text('Men vs Men'),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => GamePage(title: 'Tic Tac Toe')));
                    },
                  ),
                ))
          ],
        ));
  }
}
