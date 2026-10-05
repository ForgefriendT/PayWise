import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'app_icon.dart';

// Displays a friendly empty state message when lists have no items
class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String icon;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon = 'history',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.brandSoft,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppIcon(icon, size: 28, color: AppColors.brand),
              ),
            ),
            const SizedBox(height: 16),
            Text(title, style: AppTextStyles.heading),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
