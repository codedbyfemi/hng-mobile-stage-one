# HNG Mobile Stage One - Tech Trivia Quiz App

A Flutter-based interactive tech trivia quiz application with SQLite persistence, designed for the HNG Mobile Stage One challenge.

## Overview

Tech Trivia Quiz is an educational mobile application that tests users' knowledge of technology concepts through an interactive multiple-choice quiz. The app features 10 technology-related questions, persistent score tracking, and seamless navigation.

## Features

- **10 Interactive Questions**: Technology-focused trivia questions covering AI, programming, databases, and more
- **One Question Per Page**: Clean, focused UI with one question displayed at a time
- **Bidirectional Navigation**: Move forward and backward through questions freely
- **Answer Feedback**: Instant visual feedback showing correct/incorrect answers
- **Correct Answer Display**: When a wrong answer is selected, the correct answer is displayed in a highlighted box
- **Progress Tracking**: Visual progress indicator showing quiz completion percentage
- **Final Score Display**: Comprehensive results screen showing score, total questions, and percentage
- **SQLite Database**: Local persistent storage for all quiz scores and attempts
- **Quiz History**: All scores are automatically saved with timestamps
- **Restart Capability**: Take the quiz multiple times and track progress over time

## Project Structure

```
lib/
├── main.dart                      # App entry point and MaterialApp setup
├── models/
│   └── question.dart              # Question data model class
├── services/
│   └── quiz_database.dart         # SQLite database operations and management
├── data/
│   └── questions.dart             # Quiz questions data (10 tech trivia questions)
└── screens/
    ├── quiz_screen.dart           # Main quiz interface with navigation
    └── results_screen.dart        # Final score display and restart option
```

## File Descriptions

### `main.dart`
- App initialization and entry point
- MaterialApp configuration with theme settings
- Widget setup for the application

### `models/question.dart`
- Question model class
- Properties: id, question text, options, correct answer index
- Used throughout the app to structure quiz data

### `services/quiz_database.dart`
- SQLite database initialization and management
- Singleton pattern implementation
- Methods:
  - `saveScore()`: Save quiz attempts to database
  - `getScores()`: Retrieve all historical scores
  - Database creation and schema management

### `data/questions.dart`
- Contains all 10 tech trivia questions
- Question data structure with options and correct answers
- Easy to extend with additional questions

### `screens/quiz_screen.dart`
- Main quiz interface
- Question display and answer selection
- Navigation between questions (forward/backward)
- Answer tracking and validation
- Score calculation

### `screens/results_screen.dart`
- Final results display
- Score presentation (points, percentage, visual)
- Restart quiz functionality
- Transitions back to quiz screen for retakes

## Installation

### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Dart SDK
- An IDE (Android Studio, VS Code, or IntelliJ)

### Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.8.3
```

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd hng-mobile-stage-one
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Usage

### Taking the Quiz

1. Launch the app to see the first question
2. Select an answer from the four multiple-choice options
3. Receive immediate feedback:
   - Green button = Correct answer
   - Red button = Wrong answer
   - Green feedback box shows the correct answer if you were wrong
4. Use **Next →** button to proceed to the next question
5. Use **← Previous** button to review previous questions (available from question 2 onwards)
6. Complete all 10 questions and click **View Results**

### Viewing Results

- See your final score out of 10
- View your percentage score
- All scores are automatically saved to the database
- Click **Take Quiz Again** to restart with a fresh attempt

## Features in Detail

### Progress Indicator
- Visual progress bar at the top of the quiz
- Shows completion percentage
- Question counter (e.g., "Question 3/10 (30%)")

### Answer Persistence
- Your answers are saved as you navigate
- Going back to previous questions shows your previous selection
- You can change answers before submitting the final results

### Correct Answer Display
- When you select a wrong answer, a green highlighted box appears
- Shows "Correct Answer:" label with the right option
- Helps users learn from mistakes immediately

### Database Storage
- Automatic score saving after quiz completion
- Scores stored with timestamp
- Multiple quiz attempts tracked
- Data persists across app sessions

## Quiz Questions

The app includes 10 technology trivia questions covering:

1. Artificial Intelligence (AI definition)
2. Java Programming Language History
3. Algorithm Complexity (Binary Search)
4. Cloud Services
5. Internet Protocol (HTTP)
6. Web Development Languages
7. GPU Definition
8. Data Structures (LIFO)
9. Python Release Date
10. Database Types (Relational vs Non-relational)

## Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **Database**: SQLite (sqflite)
- **State Management**: StatefulWidget
- **UI**: Material Design 3

## Code Architecture

The project follows clean architecture principles:

- **Models**: Data structure definitions
- **Services**: Business logic (database operations)
- **Data**: Static/persistent data (questions)
- **Screens**: UI presentation layer
- **Main**: App initialization

This separation of concerns makes the code:
- Easy to test
- Maintainable
- Scalable
- Reusable

## Customization

### Adding More Questions

Edit `lib/data/questions.dart`:

```dart
Question(
  id: 11,
  question: 'Your new question?',
  options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  correctAnswerIndex: 0, // Index of correct answer (0-3)
),
```

### Changing Theme Colors

Modify `lib/main.dart`:

```dart
theme: ThemeData(
  primarySwatch: Colors.blue, // Change to your preferred color
  useMaterial3: true,
),
```

### Modifying Question Count

Update the number of questions in `lib/data/questions.dart` and adjust the UI references accordingly.

## Database Management

The app creates a SQLite database (`quiz_scores.db`) that stores:
- Quiz attempt ID
- Score achieved
- Total questions
- Timestamp of attempt

To reset database scores, uninstall and reinstall the app, or delete the app data.

## Performance Considerations

- Questions are loaded in memory at startup
- Database operations are asynchronous to prevent UI blocking
- Efficient ListView builder for option rendering
- Optimized state management to minimize rebuilds

## Future Enhancements

Possible improvements for future versions:

- Score history view screen
- Multiple quiz categories
- Difficulty levels
- Leaderboard system
- Timed questions
- Question explanations
- Dark mode support
- Multiple languages
- Analytics and statistics
- Cloud score synchronization

## Testing

To run tests:

```bash
flutter test
```

## Troubleshooting

### Database not persisting
- Ensure SQLite is properly installed
- Check app permissions in device settings
- Verify database file exists in app data directory

### UI issues on different screen sizes
- The responsive design uses Expanded and flexible widgets
- Test on multiple device sizes using emulators

### Questions not displaying
- Verify `questions.dart` file path is correct
- Check imports in `quiz_screen.dart`

## Contributing

To contribute to this project:

1. Create a feature branch
2. Make your changes
3. Test thoroughly
4. Submit a pull request

## License

This project is created as part of the HNG Mobile Stage One challenge.

## Author

Created for HNG Mobile Challenge - Stage One

## Support

For issues or questions, please create an issue in the repository or contact the project maintainers.

---

**Version**: 1.0.0  
**Last Updated**: October 2024  
**Flutter Version**: 3.0+  
**Dart Version**: 3.0+