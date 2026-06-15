import 'package:equatable/equatable.dart';
import '../../data/quiz_model.dart';

enum StoryStatus { initial, loading, playing, completed, error }
enum QuizStatus { hidden, visible, incorrect, correct }

class StoryBuddyState extends Equatable {
  final StoryStatus storyStatus;
  final QuizStatus quizStatus;
  final String? errorMessage;
  final int starCount;
  final String? selectedAnswer;
  final QuizModel quizData;
  final int shakeTrigger;

  const StoryBuddyState({
    required this.storyStatus,
    required this.quizStatus,
    this.errorMessage,
    required this.starCount,
    this.selectedAnswer,
    required this.quizData,
    required this.shakeTrigger,
  });

  factory StoryBuddyState.initial(QuizModel initialQuiz) {
    return StoryBuddyState(
      storyStatus: StoryStatus.initial,
      quizStatus: QuizStatus.hidden,
      starCount: 128, // Initial value based on requirements
      quizData: initialQuiz,
      shakeTrigger: 0,
    );
  }

  StoryBuddyState copyWith({
    StoryStatus? storyStatus,
    QuizStatus? quizStatus,
    String? errorMessage,
    int? starCount,
    String? selectedAnswer,
    QuizModel? quizData,
    int? shakeTrigger,
  }) {
    return StoryBuddyState(
      storyStatus: storyStatus ?? this.storyStatus,
      quizStatus: quizStatus ?? this.quizStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      starCount: starCount ?? this.starCount,
      selectedAnswer: selectedAnswer, // Can be null, so no coalesce unless intended
      quizData: quizData ?? this.quizData,
      shakeTrigger: shakeTrigger ?? this.shakeTrigger,
    );
  }

  @override
  List<Object?> get props => [
        storyStatus,
        quizStatus,
        errorMessage,
        starCount,
        selectedAnswer,
        quizData,
        shakeTrigger,
      ];
}
