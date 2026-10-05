import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Amount entry and quick chips selector for gold transactions
class GoldAmountInput extends StatelessWidget {
  final bool isBuy;
  final double amount;
  final double liveRate;
  final TextEditingController controller;
  final ValueChanged<double> onAmountChanged;

  const GoldAmountInput({
    super.key,
    required this.isBuy,
    required this.amount,
    required this.liveRate,
    required this.controller,
    required this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    final weight = liveRate > 0 ? amount / liveRate : 0.0;
    final chips = [500.0, 1000.0, 5000.0, liveRate];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Text(isBuy ? 'Enter Purchase Amount' : 'Enter Value to Liquidate', style: AppTextStyles.caption),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('₹', style: AppTextStyles.title.copyWith(fontSize: 26, color: AppColors.brand)),
                  const SizedBox(width: 4),
                  IntrinsicWidth(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title.copyWith(fontSize: 26),
                      decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                      onChanged: (val) {
                        final p = double.tryParse(val.replaceAll(',', '')) ?? 0.0;
                        onAmountChanged(p);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999)),
                child: Text('≈ ${weight.toStringAsFixed(4)} gm', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, color: AppColors.brand)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: chips.map((c) {
            final isSel = (amount - c).abs() < 1.0;
            final label = c == liveRate ? '1 gm' : AppFormatters.formatRupee(c);
            return Expanded(
              child: GestureDetector(
                onTap: () => onAmountChanged(c),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSel ? AppColors.brandSoft : AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isSel ? AppColors.brand : AppColors.divider),
                  ),
                  child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isSel ? AppColors.brand : AppColors.textSecondary)),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
