import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/quiz_model.dart';
import '../animations/shake_animation.dart';

class QuizSection extends StatelessWidget {
  final QuizModel quizData;
  final String? selectedAnswer;
  final bool isIncorrect;
  final bool isCorrect;
  final Function(String) onAnswerSelected;

  const QuizSection({
    Key? key,
    required this.quizData,
    this.selectedAnswer,
    required this.isIncorrect,
    required this.isCorrect,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShakeAnimation(
      shake: isIncorrect,
      onAnimationComplete: () {
        // Handled naturally by state
      },
      child: Card(
        margin: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                quizData.question,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingLarge),
              ...quizData.options.map((option) {
                final isSelected = selectedAnswer == option;
                Color buttonColor = Colors.white;
                Color textColor = AppTheme.primaryColor;

                if (isSelected) {
                  if (isCorrect) {
                    buttonColor = AppTheme.successColor;
                    textColor = Colors.white;
                  } else if (isIncorrect) {
                    buttonColor = AppTheme.errorColor;
                    textColor = Colors.white;
                  }
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
                  child: OutlinedButton(
                    onPressed: isCorrect ? null : () => onAnswerSelected(option),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: textColor,
                      side: BorderSide(color: isSelected ? buttonColor : AppTheme.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
              if (isIncorrect)
                Padding(
                  padding: const EdgeInsets.only(top: AppConstants.paddingMedium),
                  child: Text(
                    AppConstants.wrongAnswerText,
                    style: TextStyle(
                      color: AppTheme.errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
