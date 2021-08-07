import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';
import 'main.dart';

class Result extends StatelessWidget {
  final questions;
  final questionIndex;
  final Function ansfun;
  Result(this.ansfun, this.questionIndex, this.questions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Question(questions[questionIndex]['question']),
        ),
        ...(questions[questionIndex]['answer'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(answer['text'], () => ansfun(answer['score']));
        }).toList(),
      ],
    );
  }
}
