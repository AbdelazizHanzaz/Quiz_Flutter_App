import 'package:flutter/foundation.dart';

import '../hive_sevice.dart';
import '../quiz_model.dart';


enum QuizState { loading, loaded, empty }

class QuizProvider with ChangeNotifier {
  List<Quiz> _quizzes = [];
  QuizState _state = QuizState.loading;
  final HiveService _hiveService = HiveService();

  List<Quiz> get quizzes => _quizzes;
  QuizState get state => _state;

  Future<void> loadQuizzes() async {
    _state = QuizState.loading;
    notifyListeners();

    _quizzes = await _hiveService.loadQuizzes();
    if (_quizzes.isNotEmpty) {
      _state = QuizState.loaded;
    } else {
      _state = QuizState.empty;
    }
    notifyListeners();
  }

  Future<void> addQuiz(Quiz quiz) async {
    await _hiveService.addQuiz(quiz);
    await loadQuizzes();
  }

  Future<void> updateQuiz(int index, Quiz updatedQuiz) async {
    await _hiveService.updateQuiz(index, updatedQuiz);
    await loadQuizzes();
  }

  Future<void> deleteQuiz(int index) async {
    await _hiveService.deleteQuiz(index);
    await loadQuizzes();
  }
}
