import 'package:flutter/material.dart';
import '../../core/animations/month_impact_ring.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import 'paypause_logic.dart';

// Projected spending impact ring card for PayPause sheet
class PayPauseRingCard extends StatelessWidget {
  final PayPauseEvaluation eval;

  const PayPauseRingCard({super.key, required this.eval});

  @override
  Widget build(BuildContext context) {
    final projectedSpend = eval.spentSoFar + eval.amount;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          MonthImpactRing(
            currentPercent: eval.currentPercent,
            projectedPercent: eval.projectedPercent,
            alertColor: eval.alertColor,
          ),
          const SizedBox(height: 12),
          _row('Current spend', AppFormatters.formatRupee(eval.spentSoFar), AppColors.textSecondary),
          const SizedBox(height: 4),
          _row('After this payment', AppFormatters.formatRupee(projectedSpend), eval.alertColor),
          const SizedBox(height: 4),
          _row('Monthly ceiling', AppFormatters.formatRupee(eval.budget), AppColors.textPrimary),
        ],
      ),
    );
  }

  Widget _row(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.caption),
        Text(value, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, color: color)),
      ],
    );
  }
}
