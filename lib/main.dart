import 'package:flutter/material.dart';
import 'question.dart';
import 'questions.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const correct = Icon(
    Icons.check,
    color: Colors.green,
  );
  static const incorrect = Icon(
    Icons.close,
    color: Colors.red,
  );

  static const List<Question> questions = Questions.basicQuestions;
  int questionNumber = 0;
  final List<Icon> results = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        questionText(),
        trueButton(),
        falseButton(),
        resultRow(),
      ],
    );
  }

  Expanded questionText() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            questions[questionNumber].question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Expanded trueButton() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          textColor: Colors.white,
          color: Colors.green,
          child: Text(
            'True',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () => setState(() {
            var question = questions[questionNumber];
            if (question.answer) {
              results.add(correct);
            } else {
              results.add(incorrect);
            }
            questionNumber = (questionNumber + 1) % questions.length;
          }),
        ),
      ),
    );
  }

  Expanded falseButton() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          color: Colors.red,
          child: Text(
            'False',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          onPressed: () => setState(() {
            var question = questions[questionNumber];
            if (question.answer) {
              results.add(incorrect);
            } else {
              results.add(correct);
            }
            questionNumber = (questionNumber + 1) % questions.length;
          }),
        ),
      ),
    );
  }

  Row resultRow() {
    return Row(
      children: results,
    );
  }
}
