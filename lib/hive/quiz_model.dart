import 'dart:io';

import 'package:hive/hive.dart';

part 'quiz_model.g.dart';

@HiveType(typeId: 0)
class Quiz extends HiveObject {
  @HiveField(0)
  late String question;

  @HiveField(1)
  late List<String> options;

  @HiveField(2)
  late int correctOptionIndex;

  @HiveField(3)
  late File? quizImage;
}
