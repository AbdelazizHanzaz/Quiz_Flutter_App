import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/category.dart';
import '../models/quiz.dart';

class HiveService {
  Future<void> initializeHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    //Register adapters
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(QuizAdapter());
    //open category box
    await Hive.openBox<Category>('category');
    //open quiz box
    await Hive.openBox<Quiz>('quiz');
  }

  Future<Box<Category>> openCategoryBox() async {
    return await Hive.openBox<Category>('categories');
  }

  Future<Box<Quiz>> openQuizBox() async {
    return await Hive.openBox<Quiz>('quizzes');
  }

  Future<List<Category>> getCategories() async {
    final box = await Hive.openBox<Category>('categories');
    return box.values.toList();
  }

  Future<List<Quiz>> getQuizzesByCategory(String category) async{
    final box = await Hive.openBox<Quiz>('quizzes');
    return box.values.where((quiz) => quiz.category == category).toList();
  }
  
   Future<void> addCategory(Category category) async{
     final box = await Hive.openBox<Category>('categories');
     box.add(category);
   }

   Future<void> deleteCategory(Category category) async{
     final box = await Hive.openBox<Category>('categories');
      final categoryIndex = box.values.toList().indexWhere((c) => c.name == category.name);
    if (categoryIndex != -1) {
      box.deleteAt(categoryIndex);
    }
   }

   Future<void> updateCategory(Category category) async{
     final box = await Hive.openBox<Category>('categories');
      final categoryIndex = box.values.toList().indexWhere((c) => c.name == category.name);
    if (categoryIndex != -1) {
      box.putAt(categoryIndex, category);
    }
   }

  Future<List<Quiz>> getQuizzes() async {
    final box = await Hive.openBox<Quiz>('quizzes');
    return box.values.toList();
  }

  Future<void> addQuiz(Quiz quiz) async {
    final box = await Hive.openBox<Quiz>('quizzes');
    box.add(quiz);
  }

  Future<void> updateQuiz(Quiz quiz) async {
    final box = await Hive.openBox<Quiz>('quizzes');
    final quizIndex = box.values.toList().indexWhere((q) => q.question == quiz.question);
    if (quizIndex != -1) {
      box.putAt(quizIndex, quiz);
    }
  }

  Future<void> deleteQuiz(Quiz quiz) async {
    final box = await Hive.openBox<Quiz>('quizzes');
    final quizIndex = box.values.toList().indexWhere((q) => q.question == quiz.question);
    if (quizIndex != -1) {
      box.deleteAt(quizIndex);
    }
  }

 

}
