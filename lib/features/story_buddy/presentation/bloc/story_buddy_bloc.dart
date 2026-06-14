import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/services/haptic_service.dart';
import '../../data/story_content.dart';
import 'story_buddy_event.dart';
import 'story_buddy_state.dart';

class StoryBuddyBloc extends Bloc<StoryBuddyEvent, StoryBuddyState> {
  final TtsService _ttsService;

  StoryBuddyBloc(this._ttsService)
      : super(StoryBuddyState.initial(StoryContent.quizData)) {
    on<StoryReadRequested>(_onStoryReadRequested);
    on<StoryNarrationStarted>(_onStoryNarrationStarted);
    on<StoryNarrationCompleted>(_onStoryNarrationCompleted);
    on<StoryNarrationFailed>(_onStoryNarrationFailed);
    on<QuizAnswerSelected>(_onQuizAnswerSelected);
  }

  Future<void> _onStoryReadRequested(
      StoryReadRequested event, Emitter<StoryBuddyState> emit) async {
    // Prevent duplicate playback requests
    if (state.storyStatus == StoryStatus.loading ||
        state.storyStatus == StoryStatus.playing) {
      return;
    }

    // Enter loading state
    emit(state.copyWith(
      storyStatus: StoryStatus.loading,
      quizStatus: QuizStatus.hidden, // Ensure quiz is hidden when re-reading
      errorMessage: null,
      selectedAnswer: null, // Reset previous answer if any
    ));

    // Simulate network/preparation delay to show loading state (optional, but good for demo)
    await Future.delayed(const Duration(seconds: 1));

    // Start TTS
    await _ttsService.speak(
      StoryContent.storyText,
      onStart: () {
        add(StoryNarrationStarted());
      },
      onComplete: () {
        add(StoryNarrationCompleted());
      },
      onError: (error) {
        add(StoryNarrationFailed(error));
      },
    );
  }

  void _onStoryNarrationStarted(
      StoryNarrationStarted event, Emitter<StoryBuddyState> emit) {
    emit(state.copyWith(storyStatus: StoryStatus.playing));
  }

  void _onStoryNarrationCompleted(
      StoryNarrationCompleted event, Emitter<StoryBuddyState> emit) {
    emit(state.copyWith(
      storyStatus: StoryStatus.completed,
      quizStatus: QuizStatus.visible, // Reveal quiz when narration is done
    ));
  }

  void _onStoryNarrationFailed(
      StoryNarrationFailed event, Emitter<StoryBuddyState> emit) {
    emit(state.copyWith(
      storyStatus: StoryStatus.error,
      errorMessage: event.errorMessage,
    ));
  }

  Future<void> _onQuizAnswerSelected(
      QuizAnswerSelected event, Emitter<StoryBuddyState> emit) async {
    // Cannot answer if already correct
    if (state.quizStatus == QuizStatus.correct) return;

    emit(state.copyWith(selectedAnswer: event.answer));

    if (event.answer == state.quizData.answer) {
      // Correct answer
      HapticService.lightImpact();
      emit(state.copyWith(
        quizStatus: QuizStatus.correct,
        starCount: state.starCount + 1,
      ));
    } else {
      // Incorrect answer
      HapticService.mediumImpact();
      emit(state.copyWith(
        quizStatus: QuizStatus.incorrect,
      ));
    }
  }

  @override
  Future<void> close() {
    _ttsService.stop();
    return super.close();
  }
}
