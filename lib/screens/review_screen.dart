// lib/screens/review_screen.dart
import 'package:flutter/material.dart';
import '../models/question.dart';

class ReviewScreen extends StatefulWidget {
  final List<Question> questions;
  final List<int?> userAnswers;
  final int score;

  const ReviewScreen({
    Key? key,
    required this.questions,
    required this.userAnswers,
    required this.score,
  }) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int currentIndex = 0;

  void _nextQuestion() {
    if (currentIndex < widget.questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentIndex];
    final userAnswer = widget.userAnswers[currentIndex];
    final isCorrect = userAnswer == question.correctAnswerIndex;
    final isUnanswered = userAnswer == null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Answers'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (currentIndex + 1) / widget.questions.length,
              minHeight: 8,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${currentIndex + 1}/${widget.questions.length}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isUnanswered
                        ? Colors.orange.withOpacity(0.2)
                        : (isCorrect ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isUnanswered ? Colors.orange : (isCorrect ? Colors.green : Colors.red),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isUnanswered ? Icons.help : (isCorrect ? Icons.check_circle : Icons.cancel),
                        size: 16,
                        color: isUnanswered ? Colors.orange : (isCorrect ? Colors.green : Colors.red),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isUnanswered ? 'Unanswered' : (isCorrect ? 'Correct' : 'Incorrect'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isUnanswered ? Colors.orange : (isCorrect ? Colors.green : Colors.red),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              question.question,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  final isOptionCorrect = index == question.correctAnswerIndex;
                  final isUserSelected = index == userAnswer;
                  
                  Color buttonColor = Colors.grey[300]!;
                  Color textColor = Colors.black87;

                  if (isOptionCorrect) {
                    buttonColor = Colors.green;
                    textColor = Colors.white;
                  } else if (isUserSelected && !isOptionCorrect) {
                    buttonColor = Colors.red;
                    textColor = Colors.white;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          if (isOptionCorrect)
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Icon(Icons.check_circle, color: textColor),
                            ),
                          if (isUserSelected && !isOptionCorrect)
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Icon(Icons.cancel, color: textColor),
                            ),
                          Expanded(
                            child: Text(
                              question.options[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (isUnanswered)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'You did not answer this question',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (currentIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _previousQuestion,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.grey[600],
                      ),
                      child: const Text('← Previous', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                if (currentIndex > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: currentIndex < widget.questions.length - 1 ? _nextQuestion : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Next →', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}