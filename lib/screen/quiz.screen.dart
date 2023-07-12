
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {

  const QuizScreen({super.key, required this.title});

  final String title;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}