import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../quiz_model.dart';
import '../state_management/quiz_provider.dart';
import '../widgets/quiz_widgets.dart';


class EditQuizScreen extends StatefulWidget {
  final int quizIndex;

  const EditQuizScreen({super.key, required this.quizIndex});

  @override
  State<EditQuizScreen> createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  late TextEditingController _questionController;
  final List<TextEditingController> _optionControllers = [];
  File? _quizImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final quiz = quizProvider.quizzes[widget.quizIndex];

    _questionController = TextEditingController(text: quiz.question);
    for (var i = 0; i < quiz.options.length; i++) {
      _optionControllers.add(TextEditingController(text: quiz.options[i]));
    }

  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.map((controller) => controller.dispose());
    super.dispose();
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


  void _saveQuiz(BuildContext context) {
    if (_formKey.currentState!.validate()) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
     final quiz = Quiz()
        ..question = _questionController.text
        ..options = _optionControllers.map((controller) => controller.text).toList()
        ..correctOptionIndex = 0
        ..quizImage = _quizImage;
    quizProvider.updateQuiz(widget.quizIndex, quiz);

    Navigator.pop(context);
  }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                onPressed: () => _saveQuiz(context),
                child: const Text('Save Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
