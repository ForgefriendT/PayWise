import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Top portfolio overview card with timeframe pills matching Stitch Screen 13
class PortfolioOverviewCard extends StatefulWidget {
  final double portfolioValue;
  final double investedValue;

  const PortfolioOverviewCard({
    super.key,
    required this.portfolioValue,
    required this.investedValue,
  });

  @override
  State<PortfolioOverviewCard> createState() => _PortfolioOverviewCardState();
}

class _PortfolioOverviewCardState extends State<PortfolioOverviewCard> {
  bool _visible = true;
  String _timeframe = '1Y';

  @override
  Widget build(BuildContext context) {
    final gain = widget.portfolioValue - widget.investedValue;
    final gainPct = widget.investedValue > 0 ? (gain / widget.investedValue) * 100 : 0.0;

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
          _buildHeader(),
          const SizedBox(height: 8),
          _buildMetric(gain, gainPct),
          const SizedBox(height: 14),
          _buildTimeframePills(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('Total Portfolio Value', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => setState(() => _visible = !_visible),
              child: Icon(_visible ? Icons.visibility : Icons.visibility_off, size: 16, color: AppColors.textSecondary),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
          child: const Text('Verified Active', style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  Widget _buildMetric(double gain, double gainPct) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _visible ? AppFormatters.formatRupee(widget.portfolioValue) : '••••••••',
          style: AppTextStyles.display.copyWith(fontSize: 32),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text('Invested: ${AppFormatters.formatRupee(widget.investedValue)}', style: AppTextStyles.caption),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
              child: Text(
                '+${gainPct.toStringAsFixed(1)}% (+${AppFormatters.formatRupee(gain)})',
                style: AppTextStyles.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.w700, fontSize: 11),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeframePills() {
    const frames = ['1M', '6M', '1Y', '3Y', 'ALL'];
    return Row(
      children: frames.map((f) {
        final isSel = _timeframe == f;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _timeframe = f),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSel ? AppColors.brandSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                f,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                  color: isSel ? AppColors.brand : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
