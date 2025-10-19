// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/quiz_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TechTriviaApp());
}

class TechTriviaApp extends StatelessWidget {
  const TechTriviaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Trivia Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const QuizScreen(),
    );
  }
}