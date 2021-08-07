import 'package:flutter/material.dart';
import 'main.dart';

class Quiz extends StatelessWidget {
  final Function reset;
  final totalScore;
  String get scoreQ {
    String scoree;
    if (totalScore > 30) {
      scoree = 'You\'re so good';
    } else
      scoree = 'fail';
    return scoree;
  }

  Quiz(this.reset, this.totalScore);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your score is $totalScore',
              style: TextStyle(fontSize: 35, color: b)),
          Text(
            scoreQ,
            style: TextStyle(fontSize: 35, color: b),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          FlatButton(
            onPressed: reset,
            color: Colors.blue,
            padding: EdgeInsets.all(15),
            child: Text(
              'Reset Quiz',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
