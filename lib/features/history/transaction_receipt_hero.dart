import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/models/payment_transaction.dart';

// Receipt hero section showing recipient avatar, name, and large amount
class TransactionReceiptHero extends StatelessWidget {
  final PaymentTransaction tx;

  const TransactionReceiptHero({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final initials = tx.counterpartyName.isNotEmpty ? tx.counterpartyName.substring(0, 1).toUpperCase() : 'P';
    final isSuccess = tx.status == 'completed' || tx.status == 'success';

    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.brandSoft,
          child: Text(initials, style: AppTextStyles.title.copyWith(color: AppColors.brand)),
        ),
        const SizedBox(height: 8),
        Text(tx.counterpartyName.isNotEmpty ? tx.counterpartyName : 'Counterparty', style: AppTextStyles.title),
        Text(tx.counterpartyUpi.isNotEmpty ? tx.counterpartyUpi : 'upi@paywise', style: AppTextStyles.caption),
        const SizedBox(height: 6),
        Text(AppFormatters.formatRupee(tx.amount), style: AppTextStyles.display.copyWith(fontSize: 32)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: (isSuccess ? AppColors.success : AppColors.danger).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            isSuccess ? 'Payment Successful' : tx.status.toUpperCase(),
            style: AppTextStyles.caption.copyWith(
              color: isSuccess ? AppColors.success : AppColors.danger,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
