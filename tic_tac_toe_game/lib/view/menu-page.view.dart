import 'package:flutter/material.dart';

import 'game-page.view.dart';

class MenuPage extends StatelessWidget {
  final String title;
  const MenuPage({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: ListView(
         children: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text('Tic Tac Toe', style: TextStyle(fontSize:40, fontWeight: FontWeight.bold))),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons.close,
                        color: Colors.blue,
                        size: 80.0,
                      ),
                      Icon(
                        Icons.circle_outlined,
                        color: Colors.pink,
                        size: 80.0,
                      ),
                  ],
                )
              ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Choose your play mode: ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
           Container(
                  padding: EdgeInsets.all(10.0),
                    child:ElevatedButton(                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Icon(
                                Icons.person,
                                color: Colors.pink,
                                size: 50.0,
                              ),
                              Text('vs'),
                              Icon(
                                Icons.person,
                                color: Colors.pink,
                                size: 50.0,
                              ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => GamePage(title: 'Tic Tac Toe')));
                    },
                  ),
            ),
                Container(
                  padding: EdgeInsets.all(10.0),                
                    child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Icon(
                                Icons.person,
                                color: Colors.pink,
                                size: 50.0,
                                semanticLabel: 'Text to announce in accessibility modes',
                              ),
                              Text('vs'),
                              Icon(
                                Icons.computer,
                                color: Colors.green,
                                size: 50.0,
                              ),
                      ],),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => GamePage(title: 'Tic Tac Toe')));
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),                
                    child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Text('Ranking', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))
                      ],),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => GamePage(title: 'Tic Tac Toe')));
                    },
                  ),
                )
          ],
        )]));
  }
}
