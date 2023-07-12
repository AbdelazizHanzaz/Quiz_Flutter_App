import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:random_quiz/hive/adapters/file_adapter.dart';
import 'package:random_quiz/hive/quiz_model.dart';

import './utils/quiz_utils';

class HiveService {
  Future<void> initHive() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter<Quiz>(QuizAdapter());
    Hive.registerAdapter<File>(FileAdapter());
    await Hive.openBox<Quiz>('quizzes');
  }

  Future<List<Quiz>> loadQuizzes() async {
    final box = Hive.box<Quiz>('quizzes');
    if (box.isEmpty) {
      // Load quiz data from your JSON file and save it to the box
      // Replace the 'loadQuizDataFromJson()' function with your implementation
      final quizzes = await QuizUtils.loadQuizDataFromJson();
      box.addAll(quizzes);
    }
    return box.values.toList();
  }

    Future<void> addQuiz(Quiz quiz) async {
    final box = Hive.box<Quiz>('quizzes');
    await box.add(quiz);
  }

  Future<void> updateQuiz(int index, Quiz updatedQuiz) async {
    final box = Hive.box<Quiz>('quizzes');
    await box.putAt(index, updatedQuiz);
  }

  Future<void> deleteQuiz(int index) async {
    final box = Hive.box<Quiz>('quizzes');
    await box.deleteAt(index);
  }
}
