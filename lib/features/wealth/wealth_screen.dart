import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';
import 'asset_allocation_bar.dart';
import 'portfolio_overview_card.dart';
import 'wealth_products_section.dart';
import 'wealth_roundups_banner.dart';

// Wealth dashboard tab matching Stitch Screen 13
class WealthScreen extends StatelessWidget {
  const WealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.userProfile;
    final goldGrams = user?.goldGrams ?? 2.5;
    final goldRate = 7425.50;
    final goldVal = goldGrams * goldRate;

    var mfVal = 0.0;
    var fdVal = 0.0;
    var mfInvested = 0.0;
    var fdInvested = 0.0;

    for (final inv in provider.investments) {
      if (inv.type == 'mf') {
        mfVal += inv.currentValue;
        mfInvested += inv.invested;
      } else {
        fdVal += inv.currentValue;
        fdInvested += inv.invested;
      }
    }
    if (mfVal == 0) {
      mfVal = 74700.0;
      mfInvested = 65000.0;
    }
    if (fdVal == 0) {
      fdVal = 18675.0;
      fdInvested = 17500.0;
    }

    final totalPortfolio = mfVal + fdVal + goldVal;
    final totalInvested = mfInvested + fdInvested + (goldGrams * 6800.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PAYWISE WEALTH', style: AppTextStyles.caption.copyWith(fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w700)),
            Text('Wealth Dashboard', style: AppTextStyles.title.copyWith(fontSize: 18)),
          ],
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: AppColors.textSecondary), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            PortfolioOverviewCard(portfolioValue: totalPortfolio, investedValue: totalInvested),
            const SizedBox(height: 14),
            const WealthRoundupsBanner(),
            const SizedBox(height: 14),
            AssetAllocationBar(mfValue: mfVal, goldValue: goldVal, fdValue: fdVal),
            const SizedBox(height: 14),
            const WealthProductsSection(),
            const SizedBox(height: 16),
            _buildFooter(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_outline, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text('Regulated by SEBI & RBI licensed partners • Simulated', style: AppTextStyles.caption.copyWith(fontSize: 11)),
      ],
    );
  }
}
