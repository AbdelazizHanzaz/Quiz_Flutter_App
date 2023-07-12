import 'package:flutter/material.dart';

class AddQuestionForm extends StatefulWidget {
  final Function(String question, List<String> options, int correctAnswer) onFormSubmitted;

  const AddQuestionForm({super.key, required this.onFormSubmitted});

  @override
  State<AddQuestionForm> createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _optionsController = List<TextEditingController>.generate(
    4,
    (index) => TextEditingController(),
  );
  final _correctAnswers = List<bool>.generate(4, (index) => false);

  final int _correctAnswerIndex = 0;

  @override
  void dispose() {
    _questionController.dispose();
    _optionsController.map((controller) => controller.dispose());
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final question = _questionController.text;
      final options = _optionsController.map((controller) => controller.text).toList();
      final correctAnswer = _correctAnswerIndex;
      widget.onFormSubmitted(question, options, correctAnswer);

         // Clear form fields
    _formKey.currentState!.reset();
    _questionController.clear();
    _optionsController.map((controller) => controller.clear());
    _correctAnswers.fillRange(0, _correctAnswers.length, false);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
          const SizedBox(height: 20),
          const Text('Options'),
                  ListView.builder(
              shrinkWrap: true,
              itemCount: _optionsController.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value: _correctAnswers[index],
                    onChanged: (value) {
                      setState(() {
                        _correctAnswers[index] = value!;
                      });
                    },
                  ),
                  title: TextFormField(
                    controller: _optionsController[index],
                    decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an option';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
