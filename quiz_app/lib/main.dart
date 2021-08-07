import 'package:flutter/material.dart';
//import 'package:quiz_app/answer.dart';
//import 'package:quiz_app/question.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/result.dart';

main() => runApp(myApp());

final List<Map<String, Object>> _questons = [
  {
    'question': 'Who was elected President of the United States in 2017?',
    'answer': [
      {'text': 'Donald Trump', 'score': 10},
      {'text': 'Barack Obama', 'score': 0},
      {'text': 'George Bush', 'score': 0},
    ]
  },
  {
    'question':
        'When did Jonas Brothers make their comeback to the music world?',
    'answer': [
      {'text': '2015', 'score': 0},
      {'text': '2011', 'score': 0},
      {'text': '2019', 'score': 10},
    ]
  },
  {
    'question': 'What is the national language of Canada?',
    'answer': [
      {'text': 'Dutch', 'score': 10},
      {'text': 'English', 'score': 0},
      {'text': 'French', 'score': 0},
    ]
  },
  {
    'question': 'What is the national animal of Pakistan?',
    'answer': [
      {'text': 'Peacock', 'score': 0},
      {'text': 'Markhor', 'score': 10},
      {'text': 'Loin', 'score': 0},
    ]
  },
  {
    'question': 'A la Crecy is a French dish made of what?',
    'answer': [
      {'text': 'Apples', 'score': 0},
      {'text': 'Carrots', 'score': 10},
      {'text': 'Potatoes', 'score': 0},
    ]
  },
];

Color w = Colors.white;
Color b = Colors.black;

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  bool isChanged = false;
  int questionIndex = 0;
  int totalScore = 0;
  int num0 = 0, num1 = 0;
  void ansfun(score) {
    if (questionIndex == 0) {
      num0 = score;
    }
    if (questionIndex == 1) {
      num1 = score;
    }
    totalScore += score;

    print(totalScore);
    print('score $score');
    setState(() {
      questionIndex += 1;
    });
  }

  void reset() {
    setState(() {
      questionIndex = 0;
      totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Survey App',
            style: TextStyle(color: w),
          ),
          actions: [
            Switch(
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Colors.black,
              activeColor: Colors.white,
              value: isChanged,
              onChanged: (value) {
                setState(() {
                  isChanged = value;
                  if (isChanged == true) {
                    b = Colors.white;
                    w = Colors.black;
                  }
                  if (isChanged == false) {
                    b = Colors.black;
                    w = Colors.white;
                  }
                });
              },
            ),
          ],
        ),
        body: questionIndex < _questons.length
            ? Result(ansfun, questionIndex, _questons)
            : Quiz(reset, totalScore),
        backgroundColor: w,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
            color: w,
          ),
          onPressed: () {
            if (questionIndex == 1) {
              totalScore -= num0;
            }
            if (questionIndex == 2) {
              totalScore -= num1;
            }
            setState(() {
              if (questionIndex > 0) {
                questionIndex--;
              }
            });
            print('num0 : $num0');
            print('num1 : $num1');
            print('total:$totalScore');
          },
        ),
      ),
    );
  }
}
