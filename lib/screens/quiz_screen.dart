// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import '../models/question.dart';
import '../services/quiz_database.dart';
import '../data/questions.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> questions;
  int currentIndex = 0;
  late List<int?> userAnswers;
  bool showResults = false;
  
  late Timer timer;
  int timeLeft = 30;
  static const int timePerQuestion = 30;

  @override
  void initState() {
    super.initState();
    questions = techTriviaQuestions;
    userAnswers = List<int?>.filled(questions.length, null);
    _startTimer();
  }

  void _startTimer() {
    timeLeft = timePerQuestion;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
      });
      
      if (timeLeft <= 0) {
        timer.cancel();
        _autoNextQuestion();
      }
    });
  }

  void _selectAnswer(int index) {
    if (userAnswers[currentIndex] == null && timeLeft > 0) {
      setState(() {
        userAnswers[currentIndex] = index;
      });
      timer.cancel();
    }
  }

  void _autoNextQuestion() {
    timer.cancel();
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
      _startTimer();
    } else {
      _showResults();
    }
  }

  void _nextQuestion() {
    timer.cancel();
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
      _startTimer();
    } else {
      _showResults();
    }
  }

  void _previousQuestion() {
    timer.cancel();
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      _startTimer();
    }
  }

  void _showResults() async {
    timer.cancel();
    int finalScore = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i].correctAnswerIndex) {
        finalScore++;
      }
    }
    await QuizDatabase().saveScore(finalScore, questions.length);
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            score: finalScore,
            totalQuestions: questions.length,
            userAnswers: userAnswers,
            questions: questions,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Color _getTimerColor() {
    if (timeLeft <= 10) return Colors.red;
    if (timeLeft <= 15) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
    final selectedAnswer = userAnswers[currentIndex];
    final percentage = ((currentIndex + 1) / questions.length * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Trivia Quiz'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (currentIndex + 1) / questions.length,
              minHeight: 8,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${currentIndex + 1}/${questions.length} ($percentage%)',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getTimerColor().withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _getTimerColor()),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.timer, size: 16, color: _getTimerColor()),
                        const SizedBox(width: 6),
                        Text(
                          '$timeLeft s',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getTimerColor(),
                            fontSize: 14,
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
                  final isSelected = selectedAnswer == index;
                  final isCorrect = index == question.correctAnswerIndex;
                  final isWrongSelection = isSelected && !isCorrect;
                  
                  Color buttonColor = Colors.grey[300]!;
                  if (isSelected) {
                    buttonColor = isCorrect ? Colors.green : Colors.red;
                  } else if (selectedAnswer != null && isCorrect) {
                    buttonColor = Colors.green;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: userAnswers[currentIndex] == null && timeLeft > 0 ? () => _selectAnswer(index) : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            disabledBackgroundColor: buttonColor,
                          ),
                          child: Text(
                            question.options[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: (isSelected || (selectedAnswer != null && isCorrect)) ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // if (isWrongSelection)
                        //   Padding(
                        //     padding: const EdgeInsets.only(top: 8.0),
                        //     child: Container(
                        //       padding: const EdgeInsets.all(12),
                        //       decoration: BoxDecoration(
                        //         color: Colors.green[50],
                        //         borderRadius: BorderRadius.circular(8),
                        //         border: Border.all(color: Colors.green, width: 2),
                        //       ),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             'Correct Answer:',
                        //             style: TextStyle(
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.green[700],
                        //             ),
                        //           ),
                        //           const SizedBox(height: 4),
                        //           Text(
                        //             question.options[question.correctAnswerIndex],
                        //             style: TextStyle(
                        //               fontSize: 14,
                        //               color: Colors.green[700],
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  );
                },
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
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      currentIndex == questions.length - 1 ? 'View Results' : 'Next →',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
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