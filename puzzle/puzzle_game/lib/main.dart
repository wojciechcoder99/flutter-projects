import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/split_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Puzzle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Puzzle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final int rows = 3;
  final int cols = 3;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pieces = [];
  List<Widget> draggable = [];
  ByteData imageData;
  Uint8List list;
  List<Image> splittedImage = [];

  initState() {
    super.initState();
    rootBundle.load('assets/images/puzzle_1.jpg').then((data) => setState(() =>
        {splittedImage = SplitImage.splitImage(data.buffer.asUint8List())}));
  }

  @override
  Widget build(BuildContext context) {
    if (splittedImage == null || splittedImage.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(title: Text('Score'), backgroundColor: Colors.pink),
          body: SizedBox(
              height:  MediaQuery.of(context).size.height,
              width: 400,
              child: Column(children: [
                Row(
                  children: splittedImage.sublist(0, 3).map((piece) {
                    return SizedBox(
                        width: 128,
                        height: 120,
                        child: Container(
                            height: 40,
                            width: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                            ),
                            child: Image(
                              image: piece.image,
                              fit: BoxFit.fill,
                              color: Colors.grey,    
                              colorBlendMode: BlendMode.color, 
                            )));
                  }).toList(),
                ),
                Row(
                  children: splittedImage.sublist(3, 6).map((piece) {
                    return SizedBox(
                        width: 128,
                        height: 120,
                        child: Container(
                            height: 40,
                            width: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                            ),
                            child: Image(
                              image: piece.image,
                              fit: BoxFit.fill,
                              color: Colors.grey,    
                              colorBlendMode: BlendMode.color, 
                            )));
                  }).toList(),
                ),
                Row(
                  children: splittedImage.sublist(6, 9).map((piece) {
                    return SizedBox(
                        width: 128,
                        height: 120,
                        child: Container(
                            height: 40,
                            width: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: Colors.grey,
                            ),
                            child: Image(
                              image: piece.image,
                              fit: BoxFit.fill,     
                              color: Colors.grey,    
                              colorBlendMode: BlendMode.color,             
                            )));
                  }).toList(),
                ),
                SizedBox(
                    height: 362,
                    width: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                        splittedImage.sublist(0,3).map((puzzle) {
                          return Draggable<Container>(
                            data: Container(
                            height: 150,
                            width: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: Colors.grey,
                            ),
                            child: Image(
                              image: puzzle.image,
                              fit: BoxFit.fill,     
                              color: Colors.grey,    
                              colorBlendMode: BlendMode.color,  
                              height: 150,           
                            )),
                            child: Image(
                              image: puzzle.image,
                              fit: BoxFit.fill,     
                              height: 90,       
                            ),
                            feedback: Image(
                              image: puzzle.image,
                              fit: BoxFit.fill,     
                              color: Colors.grey,    
                              colorBlendMode: BlendMode.color,             
                            ),
                            childWhenDragging: null,
                          );
                        }).toList()..shuffle(Random(0)),
          )         
                    )
              ])));
    }
  }

  Widget _buildDragTarget(puzzle) {
    return DragTarget<Widget>(
      builder: (BuildContext context, List<Widget> incoming, List rejected) {
        if (true) {
          return Container(
            color: Colors.white,
            child: puzzle,
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == puzzle,
      onAccept: (data) {
        setState(() {});
      },
      onLeave: (data) {},
    );
  }
}