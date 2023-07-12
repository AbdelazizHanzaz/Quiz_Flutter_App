import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'quiz.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE quiz (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question TEXT,
            options TEXT,
            correctAnswer INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllQuestions() async {
    final Database db = await instance.database;
    return await db.query('quiz');
  }

  Future<int> insertQuestion(Map<String, dynamic> question) async {
    final Database db = await database;
  const String sql = 'INSERT INTO quiz (question, options, correctAnswer) VALUES (?, ?, ?)';
  final List<dynamic> args = [
    question['question'],
    question['options'],
    int.parse(question['correctAnswer'].toString()),
  ];
  return await db.rawInsert(sql, args);
  }

  Future<int> updateQuestion(Map<String, dynamic> question) async {
    final Database db = await instance.database;
    final int id = question['id'];
    return await db.update('quiz', question, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteQuestion(int id) async {
    final Database db = await instance.database;
    return await db.delete('quiz', where: 'id = ?', whereArgs: [id]);
  }
}
