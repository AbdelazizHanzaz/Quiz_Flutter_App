import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_quiz/hive/widgets/quiz_widgets.dart';

import '../quiz_model.dart';
import '../state_management/quiz_provider.dart';


class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  File? _quizImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _addQuiz(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      final quiz = Quiz()
        ..question = _questionController.text
        ..options = _optionControllers.map((controller) => controller.text).toList()
        ..correctOptionIndex = 0
        ..quizImage = _quizImage;

      quizProvider.addQuiz(quiz);

      Navigator.pop(context);
    }
  }

  void _setQuizImageNull(){
    setState(() {
      _quizImage = null;
    });
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _quizImage = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionController.dispose();
    _optionControllers.map((controller) => controller.dispose());
    super.dispose();
  }

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
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Options'),
              QuizWidgets.buildOptionTextFields(_optionControllers),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _optionControllers.add(TextEditingController());
                  });
                },
              ),
              const SizedBox(height: 16.0),
              QuizWidgets.buildQuizImage(_quizImage, _setQuizImageNull, _pickImage),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _addQuiz(context),
                child: const Text('Add Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }




}