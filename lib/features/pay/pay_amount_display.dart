import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Recipient info and amount preview display
class PayAmountDisplay extends StatelessWidget {
  final String upiId;
  final String amountStr;
  final double walletBalance;

  const PayAmountDisplay({
    super.key,
    required this.upiId,
    required this.amountStr,
    required this.walletBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(upiId, style: AppTextStyles.caption.copyWith(color: AppColors.brand)),
        const SizedBox(height: 16),
        Text(amountStr.isEmpty ? '₹0' : '₹$amountStr', style: AppTextStyles.display.copyWith(fontSize: 40)),
        Text('Wallet balance: ${AppFormatters.formatRupee(walletBalance)}', style: AppTextStyles.caption),
        const SizedBox(height: 12),
      ],
    );
  }
}
