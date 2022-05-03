import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizAppState();
  }
}

class QuizAppState extends State<QuizApp> {
  var questions = [
    'What\'s your favorite color?', 
    'What\'s your favorite color?', 'What\'s your favorite animal?'
  ];
  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: Column(
        children: [
          Text(questions[questionIndex]),
          ElevatedButton(child: Text('Answer 1'), onPressed: answerQuestion),
          ElevatedButton(child: Text('Answer 2'), onPressed: answerQuestion),
          ElevatedButton(child: Text('Answer 3'), onPressed: answerQuestion),
        ],
      ),
    ));
  }

  void answerQuestion() {
    setState(() {
      questionIndex = questionIndex + 1;
      print('Answer chosen!');
    });
  }
}
