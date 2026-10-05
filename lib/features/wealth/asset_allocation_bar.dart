import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Visual multi-segment asset allocation bar matching Stitch Screen 13
class AssetAllocationBar extends StatelessWidget {
  final double mfValue;
  final double goldValue;
  final double fdValue;

  const AssetAllocationBar({
    super.key,
    this.mfValue = 74700.0,
    this.goldValue = 31125.0,
    this.fdValue = 18675.0,
  });

  @override
  Widget build(BuildContext context) {
    final total = (mfValue + goldValue + fdValue).clamp(1.0, double.infinity);
    final mfPct = (mfValue / total) * 100;
    final goldPct = (goldValue / total) * 100;
    final fdPct = (fdValue / total) * 100;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Asset Allocation', style: AppTextStyles.title.copyWith(fontSize: 16)),
              Text('3 Holdings', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 10,
              child: Row(
                children: [
                  Expanded(flex: (mfPct * 10).round(), child: Container(color: AppColors.brand)),
                  const SizedBox(width: 2),
                  Expanded(flex: (goldPct * 10).round(), child: Container(color: AppColors.warning)),
                  const SizedBox(width: 2),
                  Expanded(flex: (fdPct * 10).round(), child: Container(color: AppColors.info)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _buildRow('Mutual Funds', '${mfPct.toStringAsFixed(0)}% portfolio share', AppColors.brand, mfValue, '+15.4%', AppColors.success),
          const Divider(height: 16, color: AppColors.divider),
          _buildRow('Digital Gold', '${goldPct.toStringAsFixed(0)}% portfolio share', AppColors.warning, goldValue, '+9.8%', AppColors.success),
          const Divider(height: 16, color: AppColors.divider),
          _buildRow('Fixed Deposits', '${fdPct.toStringAsFixed(0)}% portfolio share', AppColors.info, fdValue, 'Lock-in: 11 mos', AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String subtitle, Color dotColor, double amount, String trailingBadge, Color badgeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 10, height: 10, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
                Text(subtitle, style: AppTextStyles.caption.copyWith(fontSize: 11)),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(AppFormatters.formatRupee(amount), style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, fontSize: 13)),
            Text(trailingBadge, style: AppTextStyles.caption.copyWith(color: badgeColor, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
