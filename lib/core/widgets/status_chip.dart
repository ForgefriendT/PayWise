import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

// Displays transaction or entity status as a colored badge
class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;

    switch (status.toLowerCase()) {
      case 'success':
      case 'completed':
        bg = const Color(0xFFE8F7EE);
        fg = AppColors.success;
        label = 'Completed';
        break;
      case 'pending':
      case 'processing':
        bg = const Color(0xFFFEF6E6);
        fg = AppColors.warning;
        label = 'Processing';
        break;
      case 'failed':
      default:
        bg = const Color(0xFFFBECEC);
        fg = AppColors.danger;
        label = 'Failed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
