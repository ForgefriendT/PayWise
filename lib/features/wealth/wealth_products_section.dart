import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import 'fd_calculator_sheet.dart';
import 'mutual_funds_sheet.dart';
import 'wealth_product_card.dart';

// Explore investment products cards matching Stitch Screen 13
class WealthProductsSection extends StatelessWidget {
  const WealthProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Explore Products', style: AppTextStyles.title.copyWith(fontSize: 16)),
            Text('View All', style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 12),
        _buildMfCard(context),
        const SizedBox(height: 12),
        _buildGoldCard(context),
        const SizedBox(height: 12),
        _buildFdCard(context),
      ],
    );
  }

  Widget _buildMfCard(BuildContext context) {
    return WealthProductCard(
      icon: 'mutual-fund',
      iconColor: AppColors.brand,
      title: 'Mutual Funds',
      badge: 'Top Performer',
      badgeBg: AppColors.brandSoft,
      badgeColor: AppColors.brand,
      subtitle: 'SIP & Lumpsum',
      infoLeft: 'Benchmark Tracking',
      infoRight: 'Nifty 50 Index 1Y: +18.4%',
      action: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(0, 44), side: const BorderSide(color: AppColors.divider)),
              onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const MutualFundsSheet()),
              child: const Text('Explore Funds', style: TextStyle(color: AppColors.brand, fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, minimumSize: const Size(0, 44)),
              onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const MutualFundsSheet()),
              child: const Text('Start SIP (₹500)', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoldCard(BuildContext context) {
    return WealthProductCard(
      icon: 'gold',
      iconColor: AppColors.warning,
      title: 'Digital 24K Gold',
      badge: 'Live Rate ₹7,425/g',
      badgeBg: AppColors.warning.withValues(alpha: 0.15),
      badgeColor: AppColors.warning,
      subtitle: 'Instant Liquidity • Vaulted',
      infoLeft: 'Purity Assurance',
      infoRight: '0% Making Charges • 99.9%',
      action: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, minimumSize: const Size(double.infinity, 44)),
        onPressed: () => context.push('/gold'),
        icon: const Icon(Icons.add, size: 18, color: Colors.white),
        label: const Text('Buy Gold', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildFdCard(BuildContext context) {
    return WealthProductCard(
      icon: 'fd',
      iconColor: AppColors.info,
      title: 'Fixed Deposits',
      badge: 'Up to 9.0% p.a.',
      badgeBg: AppColors.info.withValues(alpha: 0.12),
      badgeColor: AppColors.info,
      subtitle: 'Guaranteed Returns',
      infoLeft: 'Safety Rating',
      infoRight: 'DICGC Insured up to ₹5 Lakhs',
      action: OutlinedButton(
        style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 44), side: const BorderSide(color: AppColors.divider)),
        onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const FdCalculatorSheet()),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('View FD Rates', style: TextStyle(color: AppColors.brand, fontSize: 13, fontWeight: FontWeight.w700)),
            SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 18, color: AppColors.brand),
          ],
        ),
      ),
    );
  }
}
