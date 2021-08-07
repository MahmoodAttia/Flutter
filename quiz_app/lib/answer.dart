import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  Function answerFun;
  final String answer;
  Answer(this.answer, this.answerFun);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      child: RaisedButton(
        onPressed: answerFun,
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(answer),
      ),
    );
  }
}
