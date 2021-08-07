import 'package:flutter/material.dart';
import 'main.dart';

class Question extends StatelessWidget {
  String q;
  Question(this.q);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: Text(
        q,
        style: TextStyle(fontSize: 30, color: b),
//        textAlign: TextAlign.center,
      ),
    );
  }
}
