import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quiz/hive/quiz_state.dart';
import 'package:random_quiz/hive/quiz_widget.dart';

// A widget that provides the `QuizState` object to its children.
class QuizProvider extends StatelessWidget {
 
   const QuizProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizState>(
      create: (context) => QuizState(),
      child: const QuizWidget(),
    );
  }
}