import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:random_quiz/hive/question.dart';



class QuizState extends ChangeNotifier {
  int currentQuestionIndex = 0;
  List<Question> questions = [];
  bool isCorrect = false;

  QuizState() {
    questions = Hive.box<Question>('questions').values.toList();
  }

  void nextQuestion() {
    currentQuestionIndex++;
    if (currentQuestionIndex >= questions.length) {
      currentQuestionIndex = 0;
    }
    notifyListeners();
  }

  void checkAnswer(String answer) {
    int answerIndex = questions[currentQuestionIndex].answers.indexOf(answer);
    isCorrect = questions[currentQuestionIndex].correctAnswer == answerIndex;
    //isCorrect = questions[currentQuestionIndex].correctAnswer == answerIndex;
    notifyListeners();
  }
}
