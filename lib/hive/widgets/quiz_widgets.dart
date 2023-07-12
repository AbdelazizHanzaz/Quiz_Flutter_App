

import 'dart:io';

import 'package:flutter/material.dart';

class QuizWidgets{

    static Widget buildQuizImage(File? quizImage, void Function() setStateQuizImage, void Function() pickImage) {
    if (quizImage != null) {
      return Column(
        children: [
          Image.file(quizImage),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: setStateQuizImage,
            child: const Text('Remove Image'),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          ElevatedButton(
            onPressed: pickImage,
            child: const Text('Pick Image'),
          ),
          const SizedBox(height: 16.0),
          const Text('No Image Selected'),
        ],
      );
    }
  }

   static Widget buildOptionTextFields(List<TextEditingController> optionControllers) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: optionControllers.length,
      itemBuilder: (context, index) {
        return TextFormField(
          controller: optionControllers[index],
          decoration: InputDecoration(labelText: 'Option ${index + 1}'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter an option';
            }
            return null;
          },
        );
      },
    );
  }
}