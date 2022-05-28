import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/shuffled_pieces_widget.dart';
import 'package:flutter_complete_guide/widgets/splitted_row_widget.dart';
import 'package:flutter_complete_guide/split_image.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

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
  ByteData imageData;
  Uint8List list;
  List<Image> splittedImage = [];
  List<Image> shuffledImage = [];
  final Map<String, bool> fittedImages = {};

  initState() {
    super.initState();
    List<Image> helper;
    rootBundle
        .load('assets/images/puzzle_1.jpg')
        .then((data) => setState(() => {
              helper = SplitImage.splitImage(data.buffer.asUint8List()),
              for (int i = 0; i < helper.length; i++)
                {
                  splittedImage.add(Image(
                    image: helper[i].image,
                    semanticLabel: i.toString(),
                  )),
                  fittedImages[i.toString()] = false,
                },
                shuffledImage.addAll(splittedImage),
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (splittedImage == null || splittedImage.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(title: Text('Score'), backgroundColor: Colors.pink),
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 400,
              child: Column(children: [
                SplittedRow(
                    splittedImage: splittedImage,
                    start: 0,
                    end: 3,
                    fittedImages: fittedImages),
                SplittedRow(
                    splittedImage: splittedImage,
                    start: 3,
                    end: 6,
                    fittedImages: fittedImages),
                SplittedRow(
                    splittedImage: splittedImage,
                    start: 6,
                    end: 9,
                    fittedImages: fittedImages),
                Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShuffledPieces(
                              shuffledImage: shuffledImage.sublist(0, 3)),
                          ShuffledPieces(
                              shuffledImage: shuffledImage.sublist(3, 6)),
                          ShuffledPieces(
                              shuffledImage: shuffledImage.sublist(6, 9)),
                        ]))
              ])));
    }
  }
}
