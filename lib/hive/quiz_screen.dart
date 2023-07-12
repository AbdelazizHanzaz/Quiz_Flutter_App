import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quiz/hive/state_management/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final quizzes = quizProvider.quizzes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return ListTile(
            title: Text(quiz.question),
            subtitle: Column(
              children: quiz.options
                  .map((option) => Text(
                        option,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
