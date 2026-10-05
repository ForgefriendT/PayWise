import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';
import 'gold_action_card.dart';
import 'gold_locker_card.dart';
import 'gold_ticker_card.dart';

// Digital gold screen matching Stitch Screen 14
class DigitalGoldScreen extends StatefulWidget {
  const DigitalGoldScreen({super.key});

  @override
  State<DigitalGoldScreen> createState() => _DigitalGoldScreenState();
}

class _DigitalGoldScreenState extends State<DigitalGoldScreen> {
  double _rate = 7425.50;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.userProfile;
    final goldGrams = user?.goldGrams ?? 2.5;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Digital 24K Gold', style: AppTextStyles.title.copyWith(fontSize: 18)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.help_outline, color: AppColors.textSecondary), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            GoldTickerCard(currentRate: _rate, onRateChanged: (newRate) => setState(() => _rate = newRate)),
            const SizedBox(height: 12),
            GoldLockerCard(goldGrams: goldGrams, liveRate: _rate),
            const SizedBox(height: 12),
            _buildSipBanner(),
            const SizedBox(height: 12),
            GoldActionCard(liveRate: _rate),
            const SizedBox(height: 16),
            _buildTrustPill(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSipBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(19)),
            alignment: Alignment.center,
            child: const Icon(Icons.autorenew, color: AppColors.brand, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Daily Gold Savings', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                      child: const Text('SIP', style: TextStyle(color: AppColors.warning, fontSize: 9, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                Text('From ₹10/day. Discipline without market stress.', style: AppTextStyles.caption.copyWith(fontSize: 11), maxLines: 1),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandSoft, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
            onPressed: () {},
            child: const Text('Start SIP', style: TextStyle(color: AppColors.brand, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.divider)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_clock_outlined, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text('Physical gold safeguarded with IDBI Trusteeship', style: AppTextStyles.caption.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}
