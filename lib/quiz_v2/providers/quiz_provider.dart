import 'package:flutter/material.dart';
import 'package:random_quiz/quiz_v2/utils/hive_service.dart';
import '../models/category.dart';
import '../models/quiz.dart';

//Quiz States
enum QuizState { loading, loaded, empty }

class QuizProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Quiz> _quizzes = [];
  QuizState _quizState = QuizState.loading;
  final HiveService _hiveService =  HiveService();

  List<Category> get categories => _categories;
  List<Quiz> get quizzes => _quizzes;
  QuizState get quizState => _quizState;

  Future<void> initialize() async {
    _quizState = QuizState.loading;
    notifyListeners();

    _categories = await _hiveService.getCategories();
    _quizzes = await _hiveService.getQuizzes();

    if(_categories.isNotEmpty && _quizzes.isNotEmpty){
      _quizState = QuizState.loaded;
    }else{
      _quizState = QuizState.empty;
    }
   
    notifyListeners();
  }
   
   Future<List<Quiz>> getQuizzesByCategory(String category){
    return _hiveService.getQuizzesByCategory(category);
   }
   
   Future<List<Category>> getCategories(){
    return _hiveService.getCategories();
   }

   
   Future<List<Quiz>> getQuizzes(){
    return _hiveService.getQuizzes();
   }
  
   Future<void> addQuiz(Quiz quiz){
    return _hiveService.addQuiz(quiz);
   }
   
   Future<void> updateQuiz(Quiz quiz){
    return _hiveService.updateQuiz(quiz);
   }

   Future<void> deleteQuiz(Quiz quiz){
    return _hiveService.deleteQuiz(quiz);
   }

   Future<void> addCategory(Category category){
    return _hiveService.addCategory(category);
   }
   
   Future<void> updateCategory(Category category){
    return _hiveService.updateCategory(category);
   }

   Future<void> deleteCategory(Category category){
    return _hiveService.deleteCategory(category);
   }
  

}
