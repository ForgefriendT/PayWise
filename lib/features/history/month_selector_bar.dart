import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Top month selector bar matching Stitch Screen 08
class MonthSelectorBar extends StatelessWidget {
  final DateTime currentMonth;
  final ValueChanged<DateTime> onMonthChanged;

  const MonthSelectorBar({
    super.key,
    required this.currentMonth,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat('MMMM yyyy').format(currentMonth);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const AppIcon('arrow-down-left', size: 18, color: AppColors.textSecondary),
            onPressed: () => onMonthChanged(DateTime(currentMonth.year, currentMonth.month - 1)),
          ),
          Row(
            children: [
              const AppIcon('history', size: 18, color: AppColors.brand),
              const SizedBox(width: 8),
              Text(
                monthLabel,
                style: AppTextStyles.bodyBold.copyWith(fontSize: 15),
              ),
            ],
          ),
          IconButton(
            icon: const AppIcon('arrow-up-right', size: 18, color: AppColors.textSecondary),
            onPressed: () => onMonthChanged(DateTime(currentMonth.year, currentMonth.month + 1)),
          ),
        ],
      ),
    );
  }
}
