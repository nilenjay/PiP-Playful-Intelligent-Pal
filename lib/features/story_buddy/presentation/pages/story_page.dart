import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../animations/slide_reveal_animation.dart';
import '../bloc/story_buddy_bloc.dart';
import '../bloc/story_buddy_event.dart';
import '../bloc/story_buddy_state.dart';
import '../widgets/confetti_overlay.dart';
import '../widgets/header_widget.dart';
import '../widgets/mission_card.dart';
import '../widgets/pip_character_widget.dart';
import '../widgets/progress_bar_widget.dart';
import '../widgets/story_card.dart';
import '../widgets/quiz_section.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_card.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: BlocConsumer<StoryBuddyBloc, StoryBuddyState>(
        listenWhen: (previous, current) => previous.quizStatus != current.quizStatus,
        listener: (context, state) {},
        builder: (context, state) {
          final bool isLoading = state.storyStatus == StoryStatus.loading;
          final bool isPlaying = state.storyStatus == StoryStatus.playing;
          final bool isCompleted = state.storyStatus == StoryStatus.completed;
          final bool isError = state.storyStatus == StoryStatus.error;
          final bool isQuizActive = state.quizStatus == QuizStatus.visible ||
              state.quizStatus == QuizStatus.incorrect ||
              state.quizStatus == QuizStatus.correct;

          return ConfettiOverlay(
            isPlaying: state.quizStatus == QuizStatus.correct,
            child: Column(
              children: [
                const HeaderWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!isLoading && !isPlaying) ...[
                          const MissionCard(),
                          const SizedBox(height: 24),
                        ],
                        
                        // Pip Character
                        const Center(child: PipCharacterWidget()),
                        const SizedBox(height: 24),

                        // Progress Bar or Loading Card
                        if (isLoading)
                          const LoadingWidget()
                        else if (!isError) ...[
                          ProgressBarWidget(
                            progress: isPlaying ? 0.5 : (isCompleted ? 1.0 : 0.0),
                            labelLeft: isPlaying ? "Pip is reading your story..." : (isCompleted ? "Story finished!" : "Ready to start!"),
                            labelRight: isPlaying ? "50%" : (isCompleted ? "100%" : "0%"),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Cards Section
                        if (isError) ...[
                          ErrorCard(
                            message: state.errorMessage,
                            onRetry: () {
                              context.read<StoryBuddyBloc>().add(StoryResetRequested());
                            },
                          ),
                        ] else if (!isLoading) ...[
                          const StoryCard(isLocked: false),
                          const SizedBox(height: 16),
                          
                          if (!isQuizActive)
                            // Locked Quiz Card
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: AppTheme.textGray.withOpacity(0.3),
                                  style: BorderStyle.solid, // Flutter doesn't have native dashed borders without a package, using solid light border for now.
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppTheme.progressBackground,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.lock, color: AppTheme.textGray),
                                  ),
                                  const SizedBox(width: 16),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Quiz Unlocks After\nStory",
                                          style: TextStyle(
                                            color: AppTheme.textGray,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Test your memory and\nearn a reward star.",
                                          style: TextStyle(
                                            color: AppTheme.textGray,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            SlideRevealAnimation(
                              isVisible: isQuizActive,
                              child: QuizSection(
                                quizData: state.quizData,
                                selectedAnswer: state.selectedAnswer,
                                isIncorrect: state.quizStatus == QuizStatus.incorrect,
                                isCorrect: state.quizStatus == QuizStatus.correct,
                                shakeTrigger: state.shakeTrigger,
                                onAnswerSelected: (answer) {
                                  context.read<StoryBuddyBloc>().add(QuizAnswerSelected(answer));
                                },
                              ),
                            ),
                        ],
                        
                        const SizedBox(height: 100), // Padding for bottom button
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<StoryBuddyBloc, StoryBuddyState>(
          builder: (context, state) {
            final bool isLoading = state.storyStatus == StoryStatus.loading;
            final bool isPlaying = state.storyStatus == StoryStatus.playing;
            final bool isError = state.storyStatus == StoryStatus.error;
            
            if (isError) return const SizedBox.shrink(); // Hide FAB on error

            String buttonText = "Read Me A Story";
            IconData? buttonIcon = Icons.play_circle_fill;
            Color bgColor = AppTheme.primaryYellow;
            Color textColor = AppTheme.textDarkBlue;

            if (isLoading) {
              buttonText = "PIP IS THINKING...";
              buttonIcon = Icons.sync;
              bgColor = AppTheme.primaryYellow.withOpacity(0.7);
            } else if (isPlaying) {
              buttonText = "Listening...";
              buttonIcon = null;
              bgColor = AppTheme.primaryYellow.withOpacity(0.5);
            }

            return Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.buttonDarkShadow.withOpacity(isLoading || isPlaying ? 0.3 : 1.0),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: (isLoading || isPlaying) ? null : () {
                    context.read<StoryBuddyBloc>().add(StoryReadRequested());
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (buttonIcon != null) ...[
                          Icon(buttonIcon, color: textColor, size: 24),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          buttonText.toUpperCase(),
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
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
      ),
    );
  }
}
