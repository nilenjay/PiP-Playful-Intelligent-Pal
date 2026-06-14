import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../animations/slide_reveal_animation.dart';
import '../animations/star_reward_animation.dart';
import '../bloc/story_buddy_bloc.dart';
import '../bloc/story_buddy_event.dart';
import '../bloc/story_buddy_state.dart';
import '../widgets/confetti_overlay.dart';
import '../widgets/error_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/quiz_section.dart';
import '../widgets/story_card.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<StoryBuddyBloc, StoryBuddyState>(
              buildWhen: (previous, current) =>
                  previous.starCount != current.starCount,
              builder: (context, state) {
                return StarRewardAnimation(count: state.starCount);
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<StoryBuddyBloc, StoryBuddyState>(
        listenWhen: (previous, current) =>
            previous.quizStatus != current.quizStatus,
        listener: (context, state) {
          if (state.quizStatus == QuizStatus.correct) {
            // Optional: You can trigger a local success dialog or snackbar here if needed
          }
        },
        builder: (context, state) {
          return ConfettiOverlay(
            isPlaying: state.quizStatus == QuizStatus.correct,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Error State
                      if (state.storyStatus == StoryStatus.error)
                        ErrorCard(
                          message: state.errorMessage,
                          onRetry: () => context
                              .read<StoryBuddyBloc>()
                              .add(StoryReadRequested()),
                        ),

                      // Main Story Card
                      if (state.storyStatus != StoryStatus.error)
                        StoryCard(
                          isPlaying: state.storyStatus == StoryStatus.playing,
                          isLoading: state.storyStatus == StoryStatus.loading,
                          onReadRequested: () => context
                              .read<StoryBuddyBloc>()
                              .add(StoryReadRequested()),
                        ),

                      // Loading State
                      if (state.storyStatus == StoryStatus.loading)
                        const Padding(
                          padding: EdgeInsets.only(top: 32.0),
                          child: LoadingWidget(),
                        ),

                      // Success Celebration Message
                      if (state.quizStatus == QuizStatus.correct)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            AppConstants.successText,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppTheme.successColor),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Quiz Section
                      SlideRevealAnimation(
                        isVisible: state.quizStatus != QuizStatus.hidden,
                        child: QuizSection(
                          quizData: state.quizData,
                          selectedAnswer: state.selectedAnswer,
                          isIncorrect: state.quizStatus == QuizStatus.incorrect,
                          isCorrect: state.quizStatus == QuizStatus.correct,
                          onAnswerSelected: (answer) {
                            context
                                .read<StoryBuddyBloc>()
                                .add(QuizAnswerSelected(answer));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
