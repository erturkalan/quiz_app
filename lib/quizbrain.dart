import 'dart:math';
import 'package:quizzler_app/main.dart';

import 'question.dart';

class QuizBrain {
  int answeredQuestionCount = 0;

  int questionNumber = Random().nextInt(13);
  List<int> askedQuestions = [];

  List<Question> questionBank = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  void nextQuestion() {
    if (askedQuestions.isEmpty) {
      askedQuestions.add(questionNumber);
    }
    int randomNumber = Random().nextInt(13);
    while (askedQuestions.indexOf(randomNumber) > -1) {
      randomNumber = Random().nextInt(13);
    }
    answeredQuestionCount++;
    questionNumber = randomNumber;
    askedQuestions.add(randomNumber);
  }

  String getQuestionText() {
    return questionBank[questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return questionBank[questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (answeredQuestionCount == questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    answeredQuestionCount = 0;
    askedQuestions = [];
  }

  bool checkLastQuestion(bool userPickedAnswer) {
    if (questionBank[answeredQuestionCount].questionAnswer ==
        userPickedAnswer) {
      return true;
    } else {
      return false;
    }
  }
}
