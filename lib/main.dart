import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:random_quiz/data/models/quiz_question.dart';
import 'package:random_quiz/data/repository/quiz_repository.dart';
import 'package:random_quiz/data/sqflite/database_helper.dart';
import 'package:random_quiz/screen/add_question_screen.dart';
import 'package:random_quiz/screen/questions_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final QuizRepository quizRepository = QuizRepository(DatabaseHelper.instance);
  final List<QuizQuestion> questions = await quizRepository.getAllQuestions();


  runApp(MyApp(questions: questions));
}

class MyApp extends StatelessWidget {
    final List<QuizQuestion> questions;

  const MyApp({super.key, required this.questions});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const TestQuizScreen(title: 'Random-Quiz'),
      initialRoute: '/home', // Set the initial route
      routes: {
        '/home': (context) => QuizQuestionScreen(questions: questions, onEdit: (id){
          log("onEdit $id");
        }, onDelete: (id) {
          log("OnDelete $id");
        },),
        '/add-question':(context) => const AddQuestionScreen(),
        // Add more routes for other screens
      },
    );
  }
}
