import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class ErrorCard extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const ErrorCard({
    Key? key,
    this.message,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: Colors.redAccent,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppConstants.errorText,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              style: const TextStyle(
                color: AppTheme.textGray,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.primaryYellow,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.buttonDarkShadow,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.refresh_rounded, color: AppTheme.textDarkBlue, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      AppConstants.retryButtonText.toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.textDarkBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
