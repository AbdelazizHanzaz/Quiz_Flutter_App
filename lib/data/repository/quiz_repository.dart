import 'dart:async';

import 'package:random_quiz/data/models/quiz_question.dart';
import 'package:random_quiz/data/sqflite/database_helper.dart';

class QuizRepository {
  final DatabaseHelper _databaseHelper;

  QuizRepository(this._databaseHelper);

  Future<List<QuizQuestion>> getAllQuestions() async {
    final List<Map<String, dynamic>> questionDataList =
        await _databaseHelper.getAllQuestions();

    return questionDataList.map((questionData) {
      return QuizQuestion.fromJson(questionData);
    }).toList();
  }

  Future<int> insertQuestion(QuizQuestion question) async {
    final Map<String, dynamic> questionData = question.toJson();
    return await _databaseHelper.insertQuestion(questionData);
  }

  Future<int> updateQuestion(QuizQuestion question) async {
    final Map<String, dynamic> questionData = question.toJson();
    return await _databaseHelper.updateQuestion(questionData);
  }

  Future<int> deleteQuestion(int id) async {
    return await _databaseHelper.deleteQuestion(id);
  }
}
