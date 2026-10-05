import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Calculated EMI breakdown and mindful safe-zone display card
class EmiResultCard extends StatelessWidget {
  final double emi;
  final double totalInterest;
  final double safeRatio;
  final bool isSafe;

  const EmiResultCard({
    super.key,
    required this.emi,
    required this.totalInterest,
    required this.safeRatio,
    required this.isSafe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Monthly Repayment (EMI)', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                  Text('${AppFormatters.formatRupee(emi)}/mo', style: AppTextStyles.title.copyWith(fontSize: 22, color: AppColors.brand)),
                ],
              ),
              const Icon(Icons.payments_outlined, color: AppColors.brand, size: 28),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniMetric('Rate', '10.5% p.a.'),
              _buildMiniMetric('Proc Fee', '₹999'),
              _buildMiniMetric('Total Interest', AppFormatters.formatRupee(totalInterest)),
            ],
          ),
          const Divider(height: 16, color: AppColors.divider),
          Row(
            children: [
              Icon(isSafe ? Icons.health_and_safety : Icons.warning_amber, size: 16, color: isSafe ? AppColors.success : AppColors.warning),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'EMI is ${safeRatio.toStringAsFixed(1)}% of income (Safe zone: <30%)',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isSafe ? AppColors.success : AppColors.warning),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: AppColors.textPrimary)),
      ],
    );
  }
}
