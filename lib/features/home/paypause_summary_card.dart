import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// PayPause guardrail summary card matching Stitch Screen 02
class PayPauseSummaryCard extends StatelessWidget {
  final double savedAmount;
  final int pauseCount;
  final VoidCallback? onInsightsTap;

  const PayPauseSummaryCard({
    super.key,
    required this.savedAmount,
    required this.pauseCount,
    this.onInsightsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.brand),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 10),
                    _buildSavingsBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(color: AppColors.brandTint, shape: BoxShape.circle),
              child: const Center(child: AppIcon('shield', size: 16, color: AppColors.brand)),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('PayPause Active', style: AppTextStyles.bodyBold.copyWith(fontSize: 14)),
                    const SizedBox(width: 6),
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                  ],
                ),
                Text('Intentional spending guardrail', style: AppTextStyles.caption.copyWith(fontSize: 11)),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: onInsightsTap,
          child: Row(
            children: [
              Text('Insights', style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700)),
              const SizedBox(width: 2),
              const AppIcon('arrow_right', size: 12, color: AppColors.brand),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSavingsBar() {
    final countLabel = pauseCount == 1 ? '1 txn' : '$pauseCount txns';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Saved by pausing', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
          Row(
            children: [
              Text(AppFormatters.formatRupee(savedAmount), style: AppTextStyles.bodyBold.copyWith(color: AppColors.brand, fontSize: 13)),
              const SizedBox(width: 4),
              Text('($countLabel)', style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
