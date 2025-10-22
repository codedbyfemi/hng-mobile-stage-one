// lib/screens/results_screen.dart
import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_screen.dart';
import 'review_screen.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<int?> userAnswers;
  final List<Question> questions;

  const ResultsScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
    required this.questions,
  }) : super(key: key);

  void _restartQuiz(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const QuizScreen()),
    );
  }

  void _goToReview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReviewScreen(
          questions: questions,
          userAnswers: userAnswers,
          score: score,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final percentage = ((score / totalQuestions) * 100).toStringAsFixed(1);
    final unanswered = userAnswers.where((ans) => ans == null).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Complete'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green[400],
                ),
                const SizedBox(height: 24),
                Text(
                  'Quiz Complete!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Column(
                    children: [
                      Text(
                        'Your Score',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$score / $totalQuestions',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$percentage%',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            'Correct',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '$score',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.cancel, color: Colors.red, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            'Incorrect',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '${totalQuestions - score - unanswered}',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.help, color: Colors.orange, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            'Unanswered',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '$unanswered',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _goToReview(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Review Answers',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _restartQuiz(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.grey[600],
                    ),
                    child: const Text(
                      'Take Quiz Again',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}