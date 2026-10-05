import 'package:flutter/material.dart';
import '../categories.dart';
import '../formatters.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'app_icon.dart';
import 'status_chip.dart';

// Unified tile widget for rendering a single transaction across screens
class TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final num amount;
  final String direction;
  final String status;
  final String categoryId;
  final VoidCallback? onTap;

  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.direction,
    required this.status,
    required this.categoryId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cat = AppCategories.findById(categoryId);
    final isReceived = direction == 'received';
    final sign = isReceived ? '+' : '-';
    final amountColor = isReceived ? AppColors.success : AppColors.textPrimary;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: onTap,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: cat.color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: AppIcon(cat.icon, size: 22, color: cat.color)),
      ),
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.caption,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$sign${AppFormatters.formatRupee(amount)}',
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w700,
              color: amountColor,
            ),
          ),
          if (status.toLowerCase() != 'completed' && status.toLowerCase() != 'success')
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: StatusChip(status: status),
            ),
        ],
      ),
    );
  }
}
