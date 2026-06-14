import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/story_content.dart';

class StoryCard extends StatelessWidget {
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onReadRequested;

  const StoryCard({
    Key? key,
    required this.isPlaying,
    required this.isLoading,
    required this.onReadRequested,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StoryContent.storyText,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            ElevatedButton.icon(
              onPressed: (isPlaying || isLoading) ? null : onReadRequested,
              icon: Icon(
                isPlaying ? Icons.volume_up : Icons.play_arrow,
                size: 24,
              ),
              label: Text(
                isPlaying ? 'Reading...' : AppConstants.readMeButtonText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
