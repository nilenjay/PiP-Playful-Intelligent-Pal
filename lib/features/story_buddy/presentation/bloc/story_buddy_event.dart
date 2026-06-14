import 'package:equatable/equatable.dart';

abstract class StoryBuddyEvent extends Equatable {
  const StoryBuddyEvent();

  @override
  List<Object?> get props => [];
}

class StoryReadRequested extends StoryBuddyEvent {}

class StoryNarrationStarted extends StoryBuddyEvent {}

class StoryNarrationCompleted extends StoryBuddyEvent {}

class StoryNarrationFailed extends StoryBuddyEvent {
  final String errorMessage;

  const StoryNarrationFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class QuizAnswerSelected extends StoryBuddyEvent {
  final String answer;

  const QuizAnswerSelected(this.answer);

  @override
  List<Object?> get props => [answer];
}
