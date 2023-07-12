import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../quiz_model.dart';
import '../state_management/quiz_provider.dart';
import 'add_quiz_screen.dart';
import 'edit_quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final List<Quiz> quizzes = quizProvider.quizzes;
    final QuizState quizState = quizProvider.state;

    Widget buildContent() {
      if (quizState == QuizState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (quizState == QuizState.loaded && quizzes.isNotEmpty) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      quiz.question,
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditQuizScreen(quizIndex: index),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Quiz'),
                                content: const Text('Are you sure you want to delete this quiz?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      quizProvider.deleteQuiz(index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return const Center(child: Text('No quizzes found.'));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzes'),
      ),
      body: buildContent(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddQuizScreen(),
            ),
          );
        },
      ),
    );
  }
}
