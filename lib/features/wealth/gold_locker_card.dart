import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// User gold locker holdings card with gradient background matching Stitch Screen 14
class GoldLockerCard extends StatelessWidget {
  final double goldGrams;
  final double liveRate;

  const GoldLockerCard({
    super.key,
    required this.goldGrams,
    required this.liveRate,
  });

  @override
  Widget build(BuildContext context) {
    final valuation = goldGrams * liveRate;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.brand, Color(0xFF714BA4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.brand.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildHoldingsRow(valuation),
          const SizedBox(height: 14),
          _buildReturnsBadge(),
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
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), shape: BoxShape.circle),
              alignment: Alignment.center,
              child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            Text('Your Gold Locker', style: AppTextStyles.title.copyWith(color: Colors.white, fontSize: 16)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
          child: const Row(
            children: [
              Icon(Icons.shield_outlined, size: 12, color: Colors.white),
              SizedBox(width: 4),
              Text('Insured', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHoldingsRow(double valuation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Holdings', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11)),
            const SizedBox(height: 2),
            Text('${goldGrams.toStringAsFixed(3)} gm', style: AppTextStyles.title.copyWith(color: Colors.white, fontSize: 20)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Current Valuation', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11)),
            const SizedBox(height: 2),
            Text(AppFormatters.formatRupee(valuation), style: AppTextStyles.title.copyWith(color: Colors.white, fontSize: 20)),
          ],
        ),
      ],
    );
  }

  Widget _buildReturnsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Total Return: ', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                child: const Text('+₹1,640 (+9.69%)', style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.verified_user_outlined, size: 12, color: Colors.white),
              const SizedBox(width: 4),
              Text('Bank-Grade Vault', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 10, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
