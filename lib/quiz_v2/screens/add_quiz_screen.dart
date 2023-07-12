import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/quiz.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _question;
  late List<String> _options;
  late int _correctAnswerIndex;
  late String _category;
  late String _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Question',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
                onSaved: (value) {
                  _question = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Options (comma-separated)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter options';
                  }
                  return null;
                },
                onSaved: (value) {
                  _options = value!.split(',');
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correct Answer Index',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the correct answer index';
                  }
                  return null;
                },
                onSaved: (value) {
                  _correctAnswerIndex = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Image Path',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image path';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imagePath = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final quiz = Quiz(
                      question: _question,
                      options: _options,
                      correctAnswerIndex: _correctAnswerIndex,
                      category: _category,
                      imagePath: _imagePath,
                    );

                    final box = Hive.box<Quiz>('quizzes');
                    box.add(quiz);

                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
