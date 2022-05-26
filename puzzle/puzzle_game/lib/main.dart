import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/puzzle_piece.dart';

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

  initState() {
    super.initState();
    getImage(
        Image.network('https://th.bing.com/th/id/R.28e4e5f692cafad1e66d76da5497ee3e?rik=lhDSelFli28gwA&riu=http%3a%2f%2fcdn.carbuzz.com%2fgallery-images%2f1600%2f759000%2f500%2f759587.jpg&ehk=TpJotfZ9HWOt3YXeXZLdWq9Arhp0bg3PSkD%2f1n3fQ6c%3d&risl=&pid=ImgRaw&r=0',
           width: 600, height: 600));
  }

  getImage(Image source) {
    var image = source;

    if (image != null) {
      setState(() {
        pieces.clear();
      });
      splitImage(image);
    }
  }

  void splitImage(Image image) {
    Size imageSize = Size(
      image.width,
      image.height,
    );

    for (int x = 0; x < widget.rows; x++) {
      for (int y = 0; y < widget.cols; y++) {
        setState(() {
          pieces.add(PuzzlePiece(
              key: GlobalKey(),
              image: image,
              imageSize: imageSize,
              row: x,
              col: y,
              maxRow: widget.rows,
              maxCol: widget.cols,
              bringToTop: this.bringToTop,
              sendToBack: this.sendToBack));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SizedBox(
          height: 500,
          child: Column(
          children: [Stack(
            children:[
            Container(
            alignment:  Alignment.center,
            height: 350, width: 400,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.color),
            child: Image.network('https://th.bing.com/th/id/R.28e4e5f692cafad1e66d76da5497ee3e?rik=lhDSelFli28gwA&riu=http%3a%2f%2fcdn.carbuzz.com%2fgallery-images%2f1600%2f759000%2f500%2f759587.jpg&ehk=TpJotfZ9HWOt3YXeXZLdWq9Arhp0bg3PSkD%2f1n3fQ6c%3d&risl=&pid=ImgRaw&r=0',
           width: 600, height: 600))
          ),
          Positioned(
            top: 15,
          child: Container(
            alignment:  Alignment.bottomCenter,
            height: 550, width: 400,
          child: Stack(children: pieces)))])],
        )));
  }

  void bringToTop(Widget widget) {
    setState(() {
      pieces.remove(widget);
      pieces.add(widget);
    });
  }

// when a piece reaches its final position, it will be sent to the back of the stack to not get in the way of other, still movable, pieces
  void sendToBack(Widget widget) {
    setState(() {
      pieces.remove(widget);
      pieces.insert(0, widget);
    });
  }
}
