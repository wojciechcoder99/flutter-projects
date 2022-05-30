import 'package:flutter/material.dart';

class MenuOption extends StatefulWidget {
  final StatefulWidget Puzzle;
  final String imagePath;

  MenuOption({this.Puzzle, this.imagePath});

  @override
  State<StatefulWidget> createState() {
    return _MenuOption();
  }
}

class _MenuOption extends State<MenuOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('menu-option'),
      height: 200,
      width: 300,
      color: Colors.white,
      padding: EdgeInsets.all(5.0),
        child: SizedBox(
          child: ElevatedButton(
                key: Key('menu-image-button'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => widget.Puzzle));
                },
                child: Image.asset(widget.imagePath, fit:  BoxFit.fill,),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),)));
  }
}
