import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models/payment_transaction.dart';

// Recent bill receipts list matching Stitch Screen 10
class RecentBillReceipts extends StatelessWidget {
  final List<PaymentTransaction> transactions;

  const RecentBillReceipts({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final bills = transactions.where((t) => t.category == 'bills').take(3).toList();
    if (bills.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Receipts', style: AppTextStyles.heading.copyWith(fontSize: 16)),
            Text('All Receipts', style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bills.length,
            separatorBuilder: (_, _) => const Divider(height: 1, indent: 56, color: AppColors.divider),
            itemBuilder: (context, i) {
              final b = bills[i];
              return ListTile(
                dense: true,
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: AppColors.brandSoft, shape: BoxShape.circle),
                  child: const Center(child: AppIcon('flash', size: 18, color: AppColors.brand)),
                ),
                title: Text(b.counterpartyName, style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
                subtitle: Text(AppFormatters.formatDate(b.createdAt), style: AppTextStyles.caption.copyWith(fontSize: 11)),
                trailing: Text(AppFormatters.formatRupee(b.amount), style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
              );
            },
          ),
        ),
      ],
    );
  }
}
