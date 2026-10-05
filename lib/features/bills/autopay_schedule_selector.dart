import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Execution schedule radio options for autopay
class AutopayScheduleSelector extends StatelessWidget {
  final int selectedDays;
  final ValueChanged<int> onSelect;

  const AutopayScheduleSelector({super.key, required this.selectedDays, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Execution Schedule', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        _scheduleTile(2, '2 days before due date', 'Avoid peak traffic & late fees (Smart)'),
        const SizedBox(height: 6),
        _scheduleTile(0, 'On due date', 'Pay exactly on the bill deadline'),
      ],
    );
  }

  Widget _scheduleTile(int days, String title, String subtitle) {
    final isSel = selectedDays == days;
    return InkWell(
      onTap: () => onSelect(days),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSel ? AppColors.brandSoft : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSel ? AppColors.brand : AppColors.divider),
        ),
        child: Row(
          children: [
            Icon(isSel ? Icons.radio_button_checked : Icons.radio_button_off, size: 18, color: isSel ? AppColors.brand : AppColors.textSecondary),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
              Text(subtitle, style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ])),
          ],
        ),
      ),
    );
  }
}
