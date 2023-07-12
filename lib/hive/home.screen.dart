import 'package:flutter/material.dart';
import 'package:random_quiz/hive/quiz_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Hive Quiz"),
        centerTitle: true,
      ),
      body: const QuizWidget(),
    );
  }


}