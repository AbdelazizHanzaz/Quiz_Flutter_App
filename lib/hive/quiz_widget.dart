import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quiz/hive/quiz_state.dart';

class QuizWidget extends StatelessWidget {

  const QuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //const quizState = null; context.watch<QuizState>();
     /// Gets the `QuizState` object from the provider.
    final quizState = Provider.of<QuizState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quiz'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              quizState.questions[quizState.currentQuestionIndex].question,
              style: const TextStyle(fontSize: 20),
            ),
            ...quizState.questions[quizState.currentQuestionIndex].answers
                .map((answer) {
              return GestureDetector(
                onTap: () {
                  quizState.checkAnswer(answer);
                },
                child: Text(
                  answer,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            Text(
              quizState.isCorrect ? 'Correct!' : 'Incorrect!',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}


