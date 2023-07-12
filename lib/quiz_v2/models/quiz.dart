import 'package:hive/hive.dart';

part 'quiz.g.dart';

@HiveType(typeId: 1)
class Quiz {
  @HiveField(0)
  final String question;

  @HiveField(1)
  final List<String> options;

  @HiveField(2)
  final int correctAnswerIndex;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String imagePath;

  Quiz({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
    required this.imagePath,
  });
}
