
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:random_quiz/data/models/quiz_question.dart';
import 'package:random_quiz/data/repository/quiz_repository.dart';
import 'package:random_quiz/data/sqflite/database_helper.dart';
import 'package:random_quiz/screen/widgets/navigation_menu.dart';

class TestQuizScreen extends StatefulWidget {
  final String title;
  const TestQuizScreen({super.key, required this.title});

  @override
  State<TestQuizScreen> createState() => _TestQuizScreenState();
}

class _TestQuizScreenState extends State<TestQuizScreen> {

  final QuizRepository quizRepository = QuizRepository(DatabaseHelper.instance);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const NavigationMenu(),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    
                    ElevatedButton(
                    onPressed: () async {
                      // Insert a quiz question
                      final QuizQuestion question = QuizQuestion(
                        id: 1,
                        question: 'What is the capital of France?',
                        options: ['Paris', 'Berlin', 'London', 'Rome'],
                        correctAnswer: 0,
                      );
                      await quizRepository.insertQuestion(question);
                      log('Question inserted successfully');
                    },
                    child: const Text('Insert Question'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Get all quiz questions
                      final List<QuizQuestion> questions = await quizRepository.getAllQuestions();
                      log("get all quiz questions : ${questions.length}");
                      
                    },
                    child: const Text('Get Questions'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Update a quiz question
                      final QuizQuestion updatedQuestion = QuizQuestion(
                        id: 1,
                        question: 'What is the capital of Germany?',
                        options: ['Paris', 'Berlin', 'London', 'Rome'],
                        correctAnswer: 1,
                      );
                      await quizRepository.updateQuestion(updatedQuestion);
                      log('Question updated');
                    },
                    child: const Text('Update Question'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Delete a quiz question
                      const int id = 1;
                      await quizRepository.deleteQuestion(id);
                      log('Question deleted');
                    },
                    child: const Text('Delete Question'),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

