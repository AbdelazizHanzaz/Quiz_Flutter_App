import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


import '../models/quiz.dart';

class EditQuizScreen extends StatefulWidget {
  final int quizIndex;

  const EditQuizScreen({super.key, required this.quizIndex});

  @override
  State<EditQuizScreen> createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _question;
  late List<String> _options;
  late int _correctAnswerIndex;
  late String _category;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    final box = Hive.box<Quiz>('quizzes');
    final quiz = box.getAt(widget.quizIndex);

    _question = quiz!.question;
    _options = List<String>.from(quiz.options);
    _correctAnswerIndex = quiz.correctAnswerIndex;
    _category = quiz.category;
    _imagePath = quiz.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _question,
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
                initialValue: _options.join(', '),
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
                  _options = value!.split(', ');
                },
              ),
              TextFormField(
                initialValue: _correctAnswerIndex.toString(),
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
                initialValue: _category,
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
                initialValue: _imagePath,
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

                    final editedQuiz = Quiz(
                      question: _question,
                      options: _options,
                      correctAnswerIndex: _correctAnswerIndex,
                      category: _category,
                      imagePath: _imagePath,
                    );

                    final box = Hive.box<Quiz>('quizzes');
                    box.putAt(widget.quizIndex, editedQuiz);

                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
