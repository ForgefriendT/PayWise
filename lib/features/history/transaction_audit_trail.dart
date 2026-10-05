import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// 3-step vertical audit trail timeline for transaction detail sheet matching Stitch Screen 09
class TransactionAuditTrail extends StatelessWidget {
  final DateTime timestamp;
  final String status;
  final String counterpartyName;

  const TransactionAuditTrail({
    super.key,
    required this.timestamp,
    required this.status,
    required this.counterpartyName,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = status.toLowerCase() == 'completed' || status.toLowerCase() == 'success';
    final timeStr = AppFormatters.formatTime(timestamp);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('AUDIT TRAIL', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, fontSize: 11)),
              Text('Instant Settlement', style: AppTextStyles.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 12),
          _buildStep('Payment Initiated', timeStr, 'Requested via PayWise UPI client', true, true),
          _buildStep('Bank Processing', timeStr, 'HDFC Bank (Account ending ••9024)', true, true),
          _buildStep(
            isSuccess ? 'Completed & Credited' : 'Transaction Failed',
            timeStr,
            isSuccess ? 'Credited to $counterpartyName' : 'Reversal initiated to your bank',
            true,
            false,
            color: isSuccess ? AppColors.success : AppColors.danger,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String title, String time, String desc, bool isDone, bool hasNext, {Color? color}) {
    final activeColor = color ?? AppColors.success;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
                child: const Icon(Icons.check, size: 9, color: Colors.white),
              ),
              if (hasNext)
                Expanded(
                  child: Container(width: 2, color: activeColor.withValues(alpha: 0.3)),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
                      Text(time, style: AppTextStyles.caption.copyWith(fontSize: 11)),
                    ],
                  ),
                  Text(desc, style: AppTextStyles.caption.copyWith(fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
