import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import 'emi_calculator_logic.dart';
import 'emi_result_card.dart';

// Mindful interactive EMI calculator card matching Stitch Screen 16
class LoanCustomizerCard extends StatelessWidget {
  final double loanAmount;
  final int tenureMonths;
  final double monthlyIncome;
  final ValueChanged<double> onAmountChanged;
  final ValueChanged<int> onTenureChanged;

  const LoanCustomizerCard({
    super.key,
    required this.loanAmount,
    required this.tenureMonths,
    required this.monthlyIncome,
    required this.onAmountChanged,
    required this.onTenureChanged,
  });

  @override
  Widget build(BuildContext context) {
    const rate = 0.105;
    final emi = EmiCalculatorLogic.calculateEmi(loanAmount, rate, tenureMonths);
    final totalInterest = EmiCalculatorLogic.calculateTotalInterest(emi, tenureMonths, loanAmount);
    final safeRatio = EmiCalculatorLogic.calculateSafeRatio(emi, monthlyIncome);
    final isSafe = safeRatio <= 30.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Loan Customizer', style: AppTextStyles.title.copyWith(fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
                child: const Text('10.5% p.a. Fixed', style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildAmountSlider(),
          const SizedBox(height: 14),
          _buildTenureSelector(),
          const SizedBox(height: 14),
          EmiResultCard(emi: emi, totalInterest: totalInterest, safeRatio: safeRatio, isSafe: isSafe),
        ],
      ),
    );
  }

  Widget _buildAmountSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Desired Loan Amount', style: AppTextStyles.caption),
            Text(AppFormatters.formatRupee(loanAmount), style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, color: AppColors.brand, fontSize: 16)),
          ],
        ),
        Slider(
          value: loanAmount,
          min: 10000.0,
          max: 500000.0,
          divisions: 49,
          activeColor: AppColors.brand,
          onChanged: onAmountChanged,
        ),
      ],
    );
  }

  Widget _buildTenureSelector() {
    const tenors = [6, 12, 24, 36];
    return Row(
      children: tenors.map((m) {
        final isSel = tenureMonths == m;
        return Expanded(
          child: GestureDetector(
            onTap: () => onTenureChanged(m),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSel ? AppColors.brand : AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('${m}M', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isSel ? Colors.white : AppColors.textSecondary)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
