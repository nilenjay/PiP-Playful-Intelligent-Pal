import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/story_buddy_bloc.dart';
import '../bloc/story_buddy_state.dart';

class PipCharacterWidget extends StatelessWidget {
  const PipCharacterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBuddyBloc, StoryBuddyState>(
      buildWhen: (previous, current) =>
          previous.storyStatus != current.storyStatus ||
          previous.quizStatus != current.quizStatus,
      builder: (context, state) {
        String assetPath;

        // Determine which asset to show based on state priorities
        if (state.quizStatus == QuizStatus.correct) {
          assetPath = 'assets/pip/pip_celebrate.png';
        } else if (state.storyStatus == StoryStatus.loading ||
            state.storyStatus == StoryStatus.playing) {
          assetPath = 'assets/pip/pip_thinking.png';
        } else {
          assetPath = 'assets/pip/pip_idle.png';
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Image.asset(
            assetPath,
            key: ValueKey<String>(assetPath), // Important for AnimatedSwitcher
            width: 200, // Size based on design proportion
            height: 200,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
