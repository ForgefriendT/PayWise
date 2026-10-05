import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models/bill.dart';

// Pending bill strip banner matching Stitch Screen 02
class BillsDueStrip extends StatelessWidget {
  final Bill bill;
  final VoidCallback? onPay;

  const BillsDueStrip({super.key, required this.bill, this.onPay});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 12),
          Expanded(child: _buildDetails()),
          const SizedBox(width: 8),
          _buildPayButton(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: AppIcon('flash', size: 20, color: AppColors.warning),
      ),
    );
  }

  Widget _buildDetails() {
    final diff = bill.dueDate.difference(DateTime.now()).inDays;
    final daysRemaining = diff <= 0 ? 1 : diff;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                bill.provider,
                style: AppTextStyles.bodyBold.copyWith(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                daysRemaining == 1 ? '1 day' : '$daysRemaining days',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          '${bill.category} · ${AppFormatters.formatRupee(bill.amount)} pending',
          style: AppTextStyles.caption.copyWith(fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return ElevatedButton(
      onPressed: onPay,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brand,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        elevation: 0,
      ),
      child: const Text('Pay', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }
}
