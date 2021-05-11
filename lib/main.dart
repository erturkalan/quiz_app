import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
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
  List<Widget> scoreKeeper = [
    SizedBox(
      width: 12,
    )
  ];
  int correctAnswerCount = 0;
  int wrongAnswerCount = 0;

  void checkAnswer(bool userPickedAnswer) {
    setState(() {
      if (quizBrain.isFinished() == true) {
        if (quizBrain.checkLastQuestion(userPickedAnswer) == true) {
          correctAnswerCount += 1;
        } else {
          wrongAnswerCount += 1;
        }
        Alert(
                context: context,
                title: 'Your Score:',
                desc: (correctAnswerCount).toString() +
                    ' / ' +
                    (correctAnswerCount + wrongAnswerCount).toString())
            .show();
        scoreKeeper = [];
        quizBrain.reset();
        correctAnswerCount = 0;
        wrongAnswerCount = 0;
      } else {
        bool correctanswers = quizBrain.getQuestionAnswer();
        if (correctanswers == userPickedAnswer) {
          // ignore: unnecessary_statements
          scoreKeeper.add(Icon(
            Icons.check,
            size: 30,
            color: Colors.green,
          ));
          correctAnswerCount++;
        } else {
          // ignore: unnecessary_statements
          scoreKeeper.add(Icon(
            Icons.close,
            size: 30,
            color: Colors.red,
          ));
          wrongAnswerCount++;
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
