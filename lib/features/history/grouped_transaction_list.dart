import 'package:flutter/material.dart';
import '../../core/categories.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models/payment_transaction.dart';

// Grouped transactions feed partitioned by day matching Stitch Screen 08
class GroupedTransactionList extends StatelessWidget {
  final List<PaymentTransaction> transactions;
  final ValueChanged<PaymentTransaction> onTransactionTap;

  const GroupedTransactionList({
    super.key,
    required this.transactions,
    required this.onTransactionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return const SizedBox.shrink();

    final groups = _groupByDate(transactions);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: groups.length,
      itemBuilder: (context, i) {
        final dateKey = groups.keys.elementAt(i);
        final txs = groups[dateKey]!;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(dateKey, txs.length),
              const SizedBox(height: 6),
              _buildGroupCard(txs),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDateHeader(String title, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.toUpperCase(), style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, fontSize: 11)),
          Text('$count txns', style: AppTextStyles.caption.copyWith(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildGroupCard(List<PaymentTransaction> txs) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: txs.length,
        separatorBuilder: (_, _) => const Divider(height: 1, indent: 64, color: AppColors.divider),
        itemBuilder: (context, index) => _buildTile(txs[index]),
      ),
    );
  }

  Widget _buildTile(PaymentTransaction tx) {
    final isReceived = tx.direction == 'received';
    final amountPrefix = isReceived ? '+' : '-';
    final amountColor = isReceived ? AppColors.success : AppColors.textPrimary;
    final cat = AppCategories.findById(tx.category);

    return InkWell(
      onTap: () => onTransactionTap(tx),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: cat.color.withValues(alpha: 0.12), shape: BoxShape.circle),
              child: Center(child: AppIcon(cat.icon, size: 20, color: cat.color)),
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
                    '${AppFormatters.formatTime(tx.createdAt)} • ${tx.status}',
                    style: AppTextStyles.caption.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$amountPrefix${AppFormatters.formatRupee(tx.amount)}',
              style: AppTextStyles.bodyBold.copyWith(color: amountColor, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, List<PaymentTransaction>> _groupByDate(List<PaymentTransaction> list) {
    final map = <String, List<PaymentTransaction>>{};
    for (final tx in list) {
      final key = AppFormatters.formatDate(tx.createdAt);
      map.putIfAbsent(key, () => []).add(tx);
    }
    return map;
  }
}
