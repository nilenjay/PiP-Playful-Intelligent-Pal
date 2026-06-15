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
  final int shakeTrigger;
  final Function(String) onAnswerSelected;

  const QuizSection({
    Key? key,
    required this.quizData,
    this.selectedAnswer,
    required this.isIncorrect,
    required this.isCorrect,
    required this.shakeTrigger,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShakeAnimation(
      shakeTrigger: shakeTrigger,
      onAnimationComplete: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              quizData.question,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ...quizData.options.map((option) {
              final isSelected = selectedAnswer == option;
              
              Color bgColor = AppTheme.progressBackground;
              Color shadowColor = AppTheme.textGray.withOpacity(0.2);
              Color textColor = AppTheme.textDarkBlue;

              if (isSelected) {
                if (isCorrect) {
                  bgColor = AppTheme.successGreen;
                  shadowColor = Colors.green[700]!;
                  textColor = Colors.white;
                } else if (isIncorrect) {
                  bgColor = Colors.redAccent;
                  shadowColor = Colors.red[800]!;
                  textColor = Colors.white;
                } else {
                  bgColor = AppTheme.primaryYellow;
                  shadowColor = AppTheme.buttonDarkShadow;
                  textColor = AppTheme.textDarkBlue;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: GestureDetector(
                  onTap: isCorrect ? null : () => onAnswerSelected(option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          offset: Offset(0, isSelected ? 2 : 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
            if (isIncorrect)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  AppConstants.wrongAnswerText,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (isCorrect)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  AppConstants.successText,
                  style: const TextStyle(
                    color: AppTheme.successGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
