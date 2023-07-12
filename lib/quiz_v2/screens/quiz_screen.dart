import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/quiz.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final Future<List<Quiz>> quizzesFuture = quizProvider.getQuizzes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Screen'),
      ),
      body: FutureBuilder<List<Quiz>>(
        future: quizzesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Quiz> quizzes = snapshot.data ?? [];

            return ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final Quiz quiz = quizzes[index];

                return ListTile(
                  title: Text(quiz.question),
                  subtitle: Text('Category: ${quiz.category}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Quiz'),
                            content: const Text('Are you sure you want to delete this quiz?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  quizProvider.deleteQuiz(quiz);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  onTap: () {
                    // Handle quiz tap
                    _handleQuizTap(context, quiz);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_quiz');
        },
      ),
    );
  }

  void _handleQuizTap(BuildContext context, Quiz quiz) {
    // Handle quiz tap
  }
}
