import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:random_quiz/data/models/quiz_question.dart';
import 'package:random_quiz/data/repository/quiz_repository.dart';
import 'package:random_quiz/data/sqflite/database_helper.dart';
import 'package:random_quiz/screen/widgets/add_question_form.dart';

class AddQuestionScreen extends StatelessWidget {
  const AddQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final QuizRepository quizRepository = QuizRepository(DatabaseHelper.instance);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Question"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddQuestionForm(onFormSubmitted: (question, options, correctAnswer) async {
                          final QuizQuestion newQuestion = QuizQuestion(
                            id: 0, // The actual ID will be assigned by the database
                            question: question,
                            options: options,
                            correctAnswer: correctAnswer,
                          );
                          await quizRepository.insertQuestion(newQuestion);
                          log('New question inserted: $newQuestion');
                        },
                      ),
        ),
      ),
    );
  }
}