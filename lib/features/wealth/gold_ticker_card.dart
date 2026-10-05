import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Live simulated gold rate ticker with green/red flash animation
class GoldTickerCard extends StatefulWidget {
  final double currentRate;
  final ValueChanged<double>? onRateChanged;

  const GoldTickerCard({super.key, this.currentRate = 7425.50, this.onRateChanged});

  @override
  State<GoldTickerCard> createState() => _GoldTickerCardState();
}

class _GoldTickerCardState extends State<GoldTickerCard> {
  late double _rate;
  Color _priceColor = AppColors.textPrimary;
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _rate = widget.currentRate;
    _timer = Timer.periodic(const Duration(seconds: 4), (_) => _tick());
  }

  void _tick() {
    final jitter = (_random.nextDouble() * 4.0) - 2.0; // +/- 2 rupees
    final newRate = (_rate + jitter).clamp(7200.0, 7800.0);
    final increased = newRate >= _rate;

    setState(() {
      _rate = newRate;
      _priceColor = increased ? AppColors.success : AppColors.danger;
    });

    widget.onRateChanged?.call(_rate);

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) setState(() => _priceColor = AppColors.textPrimary);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          _buildPriceRow(),
          const SizedBox(height: 12),
          _buildTrustRow(),
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
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text('Live 24K Rate (Simulated)', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
          child: const Text('+0.85% today', style: TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: AppTextStyles.display.copyWith(fontSize: 28, color: _priceColor),
              child: Text(AppFormatters.formatRupee(_rate)),
            ),
            const SizedBox(width: 4),
            Text('/ gram', style: AppTextStyles.caption),
          ],
        ),
        const Icon(Icons.show_chart, color: AppColors.success, size: 28),
      ],
    );
  }

  Widget _buildTrustRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BadgeItem(icon: Icons.verified, text: '24K 99.9% Pure'),
          _BadgeItem(icon: Icons.sell_outlined, text: '0% Making'),
          _BadgeItem(icon: Icons.lock_outline, text: 'Augmont Vault'),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _BadgeItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.brand),
        const SizedBox(width: 3),
        Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ],
    );
  }
}
