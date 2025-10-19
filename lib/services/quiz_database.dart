// lib/services/quiz_database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuizDatabase {
  static final QuizDatabase _instance = QuizDatabase._internal();
  static Database? _database;

  factory QuizDatabase() {
    return _instance;
  }

  QuizDatabase._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'quiz_scores.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE scores (
            id INTEGER PRIMARY KEY,
            score INTEGER,
            totalQuestions INTEGER,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveScore(int score, int total) async {
    final db = await database;
    await db.insert(
      'scores',
      {
        'score': score,
        'totalQuestions': total,
        'timestamp': DateTime.now().toString(),
      },
    );
  }

  Future<List<Map>> getScores() async {
    final db = await database;
    return db.query('scores', orderBy: 'timestamp DESC');
  }
}