import 'package:flutter/material.dart';
import '../../core/categories.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models/bill.dart';

// Saved bills card list with autopay toggle matching Stitch Screen 10
class SavedBillsList extends StatelessWidget {
  final List<Bill> bills;
  final ValueChanged<Bill>? onAutopayTap;
  final ValueChanged<Bill>? onPayNowTap;

  const SavedBillsList({
    super.key,
    required this.bills,
    this.onAutopayTap,
    this.onPayNowTap,
  });

  @override
  Widget build(BuildContext context) {
    if (bills.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Saved Bills Due Soon', style: AppTextStyles.heading.copyWith(fontSize: 16)),
                const SizedBox(width: 6),
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.warning, shape: BoxShape.circle)),
              ],
            ),
            Text('+ Add Biller', style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bills.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, i) => _buildBillCard(bills[i]),
        ),
      ],
    );
  }

  Widget _buildBillCard(Bill b) {
    final cat = AppCategories.findById(b.category);
    final days = b.dueDate.difference(DateTime.now()).inDays.clamp(1, 30);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(color: cat.color.withValues(alpha: 0.12), shape: BoxShape.circle),
                    child: Center(child: AppIcon(cat.icon, size: 20, color: cat.color)),
                  ),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(b.provider, style: AppTextStyles.bodyBold.copyWith(fontSize: 14)),
                    Text('Consumer ID: ${b.id}', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                  ]),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(999)),
                child: Text('Due in $days days', style: AppTextStyles.caption.copyWith(color: AppColors.warning, fontWeight: FontWeight.w700, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('BILLED AMOUNT', style: AppTextStyles.caption.copyWith(fontSize: 10, letterSpacing: 0.5)),
                Text(AppFormatters.formatRupee(b.amount), style: AppTextStyles.display.copyWith(fontSize: 22)),
              ]),
              Row(children: [
                Text('Autopay: ', style: AppTextStyles.caption),
                Text(b.autopay ? 'On' : 'Off', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, color: b.autopay ? AppColors.brand : AppColors.textSecondary)),
                const SizedBox(width: 4),
                Switch(value: b.autopay, activeThumbColor: AppColors.brand, onChanged: (_) => onAutopayTap?.call(b)),
              ]),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onAutopayTap?.call(b),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.brand), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Set up Autopay', style: TextStyle(color: AppColors.brand, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onPayNowTap?.call(b),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Pay Now', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
