import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Fixed Deposits rate calculator sheet with issuers and live return formula
class FdCalculatorSheet extends StatefulWidget {
  const FdCalculatorSheet({super.key});

  @override
  State<FdCalculatorSheet> createState() => _FdCalculatorSheetState();
}

class _FdCalculatorSheetState extends State<FdCalculatorSheet> {
  double _principal = 50000.0;
  int _tenureYears = 2;
  int _selectedIssuer = 0;

  final List<Map<String, dynamic>> _issuers = const [
    {'name': 'Bajaj Finance', 'rate': 0.0885, 'rateLabel': '8.85%'},
    {'name': 'Shriram Finance', 'rate': 0.0875, 'rateLabel': '8.75%'},
    {'name': 'Unity Small Bank', 'rate': 0.0900, 'rateLabel': '9.00%'},
  ];

  @override
  Widget build(BuildContext context) {
    final issuer = _issuers[_selectedIssuer];
    final rate = issuer['rate'] as double;
    final maturity = _principal * (1.0 + (rate * _tenureYears));
    final interest = maturity - _principal;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('High-Yield Fixed Deposits', style: AppTextStyles.title.copyWith(fontSize: 18)),
              const Text('DICGC Insured up to ₹5 Lakhs • Simulated', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            ]),
            IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => Navigator.pop(context)),
          ]),
          const SizedBox(height: 12),
          _buildIssuerChips(),
          const SizedBox(height: 12),
          _buildTenureSelector(),
          const SizedBox(height: 12),
          _buildPrincipalSlider(),
          const SizedBox(height: 12),
          _buildCalculationSummary(maturity, interest),
        ],
      ),
    );
  }

  Widget _buildIssuerChips() {
    return Row(
      children: List.generate(_issuers.length, (idx) {
        final iss = _issuers[idx];
        final isSel = _selectedIssuer == idx;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedIssuer = idx),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: isSel ? AppColors.brandSoft : AppColors.background, borderRadius: BorderRadius.circular(8), border: Border.all(color: isSel ? AppColors.brand : AppColors.divider)),
              child: Column(children: [
                Text(iss['name'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isSel ? AppColors.brand : AppColors.textPrimary), maxLines: 1),
                Text(iss['rateLabel'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isSel ? AppColors.brand : AppColors.textSecondary)),
              ]),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTenureSelector() {
    return Row(
      children: [1, 2, 3, 5].map((y) {
        final isSel = _tenureYears == y;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _tenureYears = y),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: isSel ? AppColors.brand : AppColors.background, borderRadius: BorderRadius.circular(8)),
              child: Text('${y}Y Tenor', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isSel ? Colors.white : AppColors.textSecondary)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPrincipalSlider() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Deposit Amount', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
        Text(AppFormatters.formatRupee(_principal), style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, color: AppColors.brand)),
      ]),
      Slider(value: _principal, min: 10000.0, max: 200000.0, divisions: 19, activeColor: AppColors.brand, onChanged: (v) => setState(() => _principal = v)),
    ]);
  }

  Widget _buildCalculationSummary(double maturity, double interest) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Maturity Amount', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            Text(AppFormatters.formatRupee(maturity), style: AppTextStyles.title.copyWith(color: AppColors.brand, fontSize: 18)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Text('Total Interest', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            Text('+${AppFormatters.formatRupee(interest)}', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, color: AppColors.success)),
          ]),
        ],
      ),
    );
  }
}
