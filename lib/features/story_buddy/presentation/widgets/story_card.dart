import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/story_content.dart';

class StoryCard extends StatelessWidget {
  final bool isLocked;

  const StoryCard({
    Key? key,
    this.isLocked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isLocked ? AppTheme.progressBackground : AppTheme.textDarkBlue,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isLocked ? AppTheme.progressBackground : AppTheme.primaryBlue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLocked ? Icons.lock_outline : Icons.menu_book_rounded,
              color: isLocked ? AppTheme.textGray : AppTheme.textDarkBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chapter 1: Pip's\nLost Gear",
                  style: TextStyle(
                    color: isLocked ? AppTheme.textGray : AppTheme.textDarkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isLocked ? "Complete previous chapter to unlock." : "Start the adventure in the woods",
                  style: TextStyle(
                    color: AppTheme.textGray.withOpacity(isLocked ? 0.7 : 1.0),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (!isLocked)
            const Icon(
              Icons.chevron_right_rounded,
              color: AppTheme.textDarkBlue,
              size: 32,
            ),
        ],
      ),
    );
  }
}
