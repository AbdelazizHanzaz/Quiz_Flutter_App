
import 'package:flutter/material.dart';
import 'package:random_quiz/data/models/quiz_question.dart';

class QuizQuestionScreen extends StatelessWidget {
  final List<QuizQuestion> questions;
  final Function(int id) onEdit;
  final Function(int id) onDelete;

  const QuizQuestionScreen({
    super.key,
    required this.questions,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Questions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: () => Navigator.pushNamed(context, 'quiz_screen')
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return Card(
            child: ListTile(
              title: Text(question.question),
              subtitle: Text('Correct Answer: ${question.options[question.correctAnswer]}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => onEdit(question.id),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDelete(question.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  ()=> Navigator.pushNamed(context, '/add-question'),
        child: const Icon(Icons.add),
        
        ),
    );
  }
}
