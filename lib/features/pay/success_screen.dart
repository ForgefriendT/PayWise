import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/animations/success_tick.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/primary_button.dart';

// Payment success celebration screen matching Stitch Screen 07
class SuccessScreen extends StatelessWidget {
  final double amount;
  final String recipientName;
  final String recipientUpi;
  final double cashback;
  final int rewardPoints;

  const SuccessScreen({
    super.key,
    required this.amount,
    required this.recipientName,
    required this.recipientUpi,
    required this.cashback,
    required this.rewardPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const SuccessTick(size: 84),
                  const SizedBox(height: 20),
                  Text(
                    '${AppFormatters.formatRupee(amount)} Paid',
                    style: AppTextStyles.display.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 4),
                  Text('to $recipientName ($recipientUpi)', style: AppTextStyles.caption.copyWith(fontSize: 14)),
                  const SizedBox(height: 8),
                  Text('UPI Ref: UPI/${DateTime.now().millisecondsSinceEpoch}', style: AppTextStyles.caption),
                  const SizedBox(height: 24),
                  _buildRewardsCard(),
                  const SizedBox(height: 32),
                  PrimaryButton(label: 'Done', onPressed: () => context.go('/')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRewardsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: AppColors.brandSoft, shape: BoxShape.circle),
                child: const Center(child: AppIcon('gift', size: 20, color: AppColors.brand)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cashback Earned', style: AppTextStyles.heading.copyWith(fontSize: 14)),
                    Text('${AppFormatters.formatRupee(cashback)} credited to PayWise wallet', style: AppTextStyles.caption),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(color: AppColors.divider)),
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(color: Color(0xFFFEF6E6), shape: BoxShape.circle),
                child: const Center(child: AppIcon('trophy', size: 20, color: AppColors.warning)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reward Points', style: AppTextStyles.heading.copyWith(fontSize: 14)),
                    Text('+$rewardPoints points added to loyalty balance', style: AppTextStyles.caption),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
