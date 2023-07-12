import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quiz/data/models/quiz_question.dart';
import 'package:random_quiz/data/repository/quiz_repository.dart';
import 'package:random_quiz/data/sqflite/database_helper.dart';
import 'package:random_quiz/hive/hive_sevice.dart';
import 'package:random_quiz/hive/screens/quiz_list_screen.dart';
import 'package:random_quiz/screen/add_question_screen.dart';
import 'package:random_quiz/screen/questions_screen.dart';

import 'hive/state_management/quiz_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final QuizRepository quizRepository = QuizRepository(DatabaseHelper.instance);
  final List<QuizQuestion> questions = await quizRepository.getAllQuestions();

  final hiveService = HiveService();
  await hiveService.initHive();
  
    //Hive.init('quiz-hive');
    //var box = Hive.openBox<QuizQuestion>('questions');

  // box.put('question1', {
  //   "question": "What is the capital of France?",
  //   "answers": ["Paris", "London", "Rome", "Madrid"],
  //   "correctAnswer": 0,
  // });

  // box.put('question2', {
  //   "question": "What is the name of the largest ocean in the world?",
  //   "answers": ["Pacific Ocean", "Atlantic Ocean", "Indian Ocean", "Arctic Ocean"],
  //   "correctAnswer": 0,
  // });

  // box.put('question3', {
  //   "question": "What is the name of the tallest mountain in the world?",
  //   "answers": ["Mount Everest", "Kilimanjaro", "Mount Fuji", "Mount Denali"],
  //   "correctAnswer": 0,
  // });

  runApp( ChangeNotifierProvider(
      create: (context) => QuizProvider()..loadQuizzes(),
      child: MyApp(questions: questions),
    ),);
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
      primaryColor: Colors.deepPurple,
      primarySwatch: Colors.purple,
      brightness: Brightness.light,
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
        'quiz_screen' : (context) =>  const QuizListScreen(),
        // Add more routes for other screens
      },
    );
  }
}
