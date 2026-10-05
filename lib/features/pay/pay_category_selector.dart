import 'package:flutter/material.dart';
import '../../core/categories.dart';
import '../../core/theme/colors.dart';

// Category choice chip row for payment screen
class PayCategorySelector extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const PayCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const categories = ['food', 'shopping', 'entertainment', 'travel', 'bills'];
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final catId = categories[i];
          final cat = AppCategories.findById(catId);
          final isSelected = selectedCategory == catId;

          return ChoiceChip(
            label: Text(
              cat.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
            selected: isSelected,
            selectedColor: AppColors.brand,
            backgroundColor: AppColors.surface,
            onSelected: (_) => onSelected(catId),
            side: BorderSide(
              color: isSelected ? AppColors.brand : AppColors.divider,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          );
        },
      ),
    );
  }
}
