import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ProgressBarWidget extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String labelLeft;
  final String labelRight;

  const ProgressBarWidget({
    Key? key,
    required this.progress,
    required this.labelLeft,
    required this.labelRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelLeft,
              style: const TextStyle(
                color: AppTheme.textGray,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              labelRight,
              style: const TextStyle(
                color: AppTheme.textDarkBlue,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: AppTheme.progressBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
