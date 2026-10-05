import 'package:flutter/material.dart';
import '../../core/categories.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// 2-column category percentage grid for spending breakdown
class SpendingCategoryGrid extends StatelessWidget {
  final double total;
  final Map<String, double> categoryTotals;

  const SpendingCategoryGrid({super.key, required this.total, required this.categoryTotals});

  @override
  Widget build(BuildContext context) {
    final entries = categoryTotals.entries.toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.3,
      ),
      itemCount: entries.length,
      itemBuilder: (context, i) {
        final e = entries[i];
        final cat = AppCategories.findById(e.key);
        final pct = total > 0 ? ((e.value / total) * 100).round() : 0;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: cat.color, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(cat.name, style: AppTextStyles.caption.copyWith(fontSize: 11, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppFormatters.formatRupee(e.value), style: AppTextStyles.bodyBold.copyWith(fontSize: 12)),
                  Text('$pct%', style: AppTextStyles.caption.copyWith(color: cat.color, fontWeight: FontWeight.w700, fontSize: 11)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
