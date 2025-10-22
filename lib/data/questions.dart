// lib/data/questions.dart
import '../models/question.dart';

final List<Question> techTriviaQuestions = [
  Question(
    id: 1,
    question: 'What does "AI" stand for?',
    options: ['Automated Intelligence', 'Artificial Intelligence', 'Advanced Integration', 'Autonomous Intelligence'],
    correctAnswerIndex: 1,
  ),
  Question(
    id: 2,
    question: 'Which company created the Java programming language?',
    options: ['Microsoft', 'Apple', 'Sun Microsystems', 'IBM'],
    correctAnswerIndex: 2,
  ),
  Question(
    id: 3,
    question: 'What is the time complexity of binary search?',
    options: ['O(n)', 'O(log n)', 'O(n²)', 'O(n log n)'],
    correctAnswerIndex: 1,
  ),
  Question(
    id: 4,
    question: 'Which of these is NOT a cloud service provider?',
    options: ['Amazon Web Services', 'Microsoft Azure', 'Google Cloud', 'Facebook Cloud'],
    correctAnswerIndex: 3,
  ),
  Question(
    id: 5,
    question: 'What does "HTTP" stand for?',
    options: ['Hyper Text Transfer Protocol', 'High Transfer Text Protocol', 'Home Text Transfer Protocol', 'Hyper Transfer Text Program'],
    correctAnswerIndex: 0,
  ),
  Question(
    id: 6,
    question: 'Which language is known for its use in web development?',
    options: ['Rust', 'Python', 'JavaScript', 'Go'],
    correctAnswerIndex: 2,
  ),
  Question(
    id: 7,
    question: 'What does "GPU" stand for?',
    options: ['Graphics Processing Unit', 'General Purpose Utility', 'Global Processing Unit', 'Graphics Performance Upgrade'],
    correctAnswerIndex: 0,
  ),
  Question(
    id: 8,
    question: 'Which data structure uses LIFO (Last In First Out)?',
    options: ['Queue', 'Stack', 'Array', 'Tree'],
    correctAnswerIndex: 1,
  ),
  Question(
    id: 9,
    question: 'What year did Python\'s creation begin?',
    options: ['1989', '1995', '2000', '2005'],
    correctAnswerIndex: 0,
  ),
  Question(
    id: 10,
    question: 'Which is NOT a relational database?',
    options: ['PostgreSQL', 'MySQL', 'MongoDB', 'Oracle'],
    correctAnswerIndex: 2,
  ),
];