import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Stat cards row showing live success rate, cashback, and reward points
class HomeStatCards extends StatelessWidget {
  final double successRate;
  final double cashback;
  final int rewardPoints;

  const HomeStatCards({
    super.key,
    required this.successRate,
    required this.cashback,
    required this.rewardPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(child: _buildCard('Success Rate', '${successRate.toStringAsFixed(1)}%', 'High reliability', AppColors.success, const AppIcon('check', size: 16, color: AppColors.success))),
          const SizedBox(width: 8),
          Expanded(child: _buildCard('Cashback', AppFormatters.formatRupee(cashback), 'This month', AppColors.brand, const AppIcon('gift', size: 16, color: AppColors.brand))),
          const SizedBox(width: 8),
          Expanded(child: _buildCard('Rewards', rewardPoints.toString(), 'Tier 2 Active', AppColors.warning, const AppIcon('trophy', size: 16, color: AppColors.warning))),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String val, String subtitle, Color color, Widget icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.caption.copyWith(fontSize: 10)),
              icon,
            ],
          ),
          const SizedBox(height: 8),
          Text(val, style: AppTextStyles.heading.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
          Text(subtitle, style: AppTextStyles.caption.copyWith(fontSize: 10, color: color)),
        ],
      ),
    );
  }
}
