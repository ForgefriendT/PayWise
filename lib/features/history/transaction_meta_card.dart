import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/categories.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models/payment_transaction.dart';

// Key metadata card and cashback stats matching Stitch Screen 09
class TransactionMetaCard extends StatelessWidget {
  final PaymentTransaction tx;

  const TransactionMetaCard({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final cat = AppCategories.findById(tx.category);
    final utr = 'UPI/${tx.id.isNotEmpty ? tx.id : "409218204921"}';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
          child: Column(
            children: [
              _buildRow('UPI Reference ID (UTR)', utr, isCopyable: true, context: context),
              const Divider(height: 16, color: AppColors.divider),
              _buildRow('Debited From', 'HDFC Bank ••9024'),
              const Divider(height: 16, color: AppColors.divider),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category', style: AppTextStyles.caption),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: cat.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
                    child: Row(
                      children: [
                        AppIcon(cat.icon, size: 12, color: cat.color),
                        const SizedBox(width: 4),
                        Text(cat.name, style: AppTextStyles.caption.copyWith(color: cat.color, fontWeight: FontWeight.w700, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 16, color: AppColors.divider),
              _buildRow('Transfer Type', 'P2P Instant UPI'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildRewardsRow(),
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isCopyable = false, BuildContext? context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.caption),
        Row(
          children: [
            Text(value, style: AppTextStyles.bodyBold.copyWith(fontSize: 12)),
            if (isCopyable && context != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: value));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('UTR copied to clipboard')));
                },
                child: const AppIcon('card', size: 14, color: AppColors.brand),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildRewardsRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const AppIcon('gift', size: 18, color: AppColors.success),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cashback', style: AppTextStyles.caption.copyWith(fontSize: 10)),
                    Text(
                      '${AppFormatters.formatRupee(tx.cashback > 0 ? tx.cashback : 18)} Earned',
                      style: AppTextStyles.bodyBold.copyWith(color: AppColors.success, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const AppIcon('trophy', size: 18, color: AppColors.brand),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reward Balance', style: AppTextStyles.caption.copyWith(fontSize: 10)),
                    Text('+185 Pts', style: AppTextStyles.bodyBold.copyWith(color: AppColors.brand, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
