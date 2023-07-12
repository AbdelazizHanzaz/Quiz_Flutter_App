import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quiz/quiz_v2/utils/hive_service.dart';
import 'package:random_quiz/quiz_v2/providers/quiz_provider.dart';
import 'package:random_quiz/quiz_v2/routes/app_routes.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //This is whene I use Sqflite
  // final QuizRepository quizRepository = QuizRepository(DatabaseHelper.instance);
  // final List<QuizQuestion> questions = await quizRepository.getAllQuestions();

  final hiveService = HiveService();
  await hiveService.initializeHive();

  runApp( ChangeNotifierProvider(
      create: (context) => QuizProvider()..initialize(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
    //final List<QuizQuestion> questions;

  const MyApp({super.key});

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
      initialRoute: AppRoutes.quizScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
