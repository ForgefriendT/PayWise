import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Filter pills row matching Stitch Screen 08
class HistoryFilterChips extends StatelessWidget {
  final String activeFilter;
  final int totalCount;
  final ValueChanged<String> onFilterSelected;

  const HistoryFilterChips({
    super.key,
    required this.activeFilter,
    required this.totalCount,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'id': 'all', 'label': 'All ($totalCount)'},
      {'id': 'sent', 'label': 'Sent'},
      {'id': 'received', 'label': 'Received'},
      {'id': 'bills', 'label': 'Bills'},
      {'id': 'failed', 'label': 'Failed'},
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final f = filters[i];
          final id = f['id']!;
          final isSelected = activeFilter == id;

          return GestureDetector(
            onTap: () => onFilterSelected(id),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.brandSoft : AppColors.surface,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: isSelected ? AppColors.brand : AppColors.divider),
              ),
              child: Text(
                f['label']!,
                style: AppTextStyles.caption.copyWith(
                  color: isSelected ? AppColors.brand : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
