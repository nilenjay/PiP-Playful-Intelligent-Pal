import 'quiz_model.dart';

class StoryContent {
  static const String storyText = "Once upon a time, a clever little robot named Pip lost his shiny blue gear in the Whispering Woods...";
  
  static final Map<String, dynamic> _quizJson = {
    "question": "What colour was Pip the Robot's lost gear?",
    "options": [
      "Red",
      "Green",
      "Blue",
      "Yellow"
    ],
    "answer": "Blue"
  };

  static QuizModel get quizData => QuizModel.fromJson(_quizJson);
}
