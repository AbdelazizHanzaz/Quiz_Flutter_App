import 'package:flutter/material.dart';
import 'package:random_quiz/quiz_v2/screens/add_quiz_screen.dart';
import 'package:random_quiz/quiz_v2/screens/edit_quiz_screen.dart';
import 'package:random_quiz/quiz_v2/screens/quiz_screen.dart';


class AppRoutes {
  static const String quizScreen = '/';
  static const String addQuizScreen = '/add_quiz';
  static const String editQuizScreen = '/edit_quiz';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case quizScreen:
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case addQuizScreen:
        return MaterialPageRoute(builder: (_) => const AddQuizScreen());
      case editQuizScreen:
        final args = settings.arguments as EditQuizScreenArguments;
        return MaterialPageRoute(builder: (_) => EditQuizScreen(quizIndex: args.quizIndex));
      default:
        return null;
    }
  }
}

class EditQuizScreenArguments {
  final int quizIndex;

  EditQuizScreenArguments({required this.quizIndex});
}
