import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Mutual funds exploration bottom sheet with 4 buckets and SIP vs Lumpsum
class MutualFundsSheet extends StatefulWidget {
  const MutualFundsSheet({super.key});

  @override
  State<MutualFundsSheet> createState() => _MutualFundsSheetState();
}

class _MutualFundsSheetState extends State<MutualFundsSheet> {
  bool _isSip = true;

  final List<Map<String, dynamic>> _funds = const [
    {'name': 'Nifty 50 Index Fund', 'category': 'Index Fund', 'returns3Y': 18.4, 'minSip': 500.0, 'rating': '5★'},
    {'name': 'Parag Parikh Flexi Cap', 'category': 'Flexi Cap', 'returns3Y': 22.1, 'minSip': 1000.0, 'rating': '5★'},
    {'name': 'Mirae Asset Large Cap', 'category': 'Large Cap', 'returns3Y': 16.8, 'minSip': 500.0, 'rating': '4★'},
    {'name': 'Quant Tax Plan ELSS', 'category': 'ELSS Tax Saver', 'returns3Y': 24.5, 'minSip': 500.0, 'rating': '5★'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 12),
          _buildHeader(),
          const SizedBox(height: 12),
          _buildModeToggle(),
          const SizedBox(height: 12),
          ..._funds.map((f) => _buildFundCard(f)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Explore Mutual Funds', style: AppTextStyles.title.copyWith(fontSize: 18)),
            const Text('Zero commission direct plans • Simulated', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          ],
        ),
        IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => Navigator.pop(context)),
      ],
    );
  }

  Widget _buildModeToggle() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(child: _buildToggleOption('Monthly SIP', _isSip, () => setState(() => _isSip = true))),
          Expanded(child: _buildToggleOption('One-time Lumpsum', !_isSip, () => setState(() => _isSip = false))),
        ],
      ),
    );
  }

  Widget _buildToggleOption(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: active ? AppColors.surface : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Text(text, style: TextStyle(fontSize: 12, fontWeight: active ? FontWeight.w700 : FontWeight.w500, color: active ? AppColors.brand : AppColors.textSecondary)),
      ),
    );
  }

  Widget _buildFundCard(Map<String, dynamic> f) {
    final returns = f['returns3Y'] as double;
    final minSip = f['minSip'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(f['name'] as String, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, fontSize: 13)),
              const SizedBox(height: 2),
              Text('${f['category']} • Min ${_isSip ? 'SIP' : 'Inv'}: ${AppFormatters.formatRupee(minSip)}', style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('+${returns.toStringAsFixed(1)}%', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, color: AppColors.success, fontSize: 13)),
              const Text('3Y Annualized', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
