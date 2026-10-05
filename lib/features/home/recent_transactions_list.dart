import 'package:flutter/material.dart';
import '../../core/categories.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models/payment_transaction.dart';

// Recent transactions card container matching Stitch Screen 02
class RecentTransactionsList extends StatelessWidget {
  final List<PaymentTransaction> transactions;
  final ValueChanged<PaymentTransaction>? onTransactionTap;
  final VoidCallback? onSeeAllTap;

  const RecentTransactionsList({
    super.key,
    required this.transactions,
    this.onTransactionTap,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return const SizedBox.shrink();
    final items = transactions.take(5).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1, color: AppColors.divider),
              itemBuilder: (context, index) => _buildTile(items[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Recent Transactions', style: AppTextStyles.heading),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            'See All',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.brand,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTile(PaymentTransaction tx) {
    final isReceived = tx.direction == 'received';
    final amountPrefix = isReceived ? '+' : '-';
    final amountColor = isReceived ? AppColors.success : AppColors.textPrimary;
    final cat = AppCategories.findById(tx.category);

    return InkWell(
      onTap: () => onTransactionTap?.call(tx),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cat.color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppIcon(cat.icon, size: 20, color: cat.color),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.counterpartyName.isNotEmpty ? tx.counterpartyName : 'Payment',
                    style: AppTextStyles.bodyBold.copyWith(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppFormatters.formatDateTime(tx.createdAt),
                    style: AppTextStyles.caption.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$amountPrefix${AppFormatters.formatRupee(tx.amount)}',
                  style: AppTextStyles.bodyBold.copyWith(color: amountColor, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  tx.status.toUpperCase(),
                  style: AppTextStyles.caption.copyWith(
                    color: tx.status == 'completed' ? AppColors.success : AppColors.warning,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
