import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';
import 'redemption_catalog_grid.dart';
import 'rewards_hero_card.dart';
import 'scratch_cards_banner.dart';
import 'wallet_balance_card.dart';

// Unified Rewards and Wallet hub screen matching Stitch Screen 17
class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _activeTab = 0; // 0: Rewards, 1: Wallet

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final user = app.userProfile;
    final points = user?.rewardPoints ?? 1450;
    final walletBal = user?.walletBalance ?? 14500.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PAYWISE REWARDS & WALLET', style: AppTextStyles.caption.copyWith(fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w700)),
            Text(_activeTab == 0 ? 'Rewards Center' : 'PayWise Wallet', style: AppTextStyles.title.copyWith(fontSize: 18)),
          ],
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            _buildSwitcher(),
            const SizedBox(height: 14),
            if (_activeTab == 0) ...[
              RewardsHeroCard(points: points),
              const SizedBox(height: 12),
              const ScratchCardsBanner(),
              const SizedBox(height: 14),
              RedemptionCatalogGrid(userPoints: points),
            ] else ...[
              WalletBalanceCard(balance: walletBal),
              const SizedBox(height: 14),
              _buildPayPauseProtectionCard(),
              const SizedBox(height: 14),
              _buildWalletHistory(app),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.divider)),
      child: Row(
        children: [
          Expanded(child: _buildPill(0, 'Rewards', Icons.workspace_premium)),
          Expanded(child: _buildPill(1, 'Wallet', Icons.account_balance_wallet)),
        ],
      ),
    );
  }

  Widget _buildPill(int index, String title, IconData icon) {
    final isSel = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: isSel ? AppColors.brand : Colors.transparent, borderRadius: BorderRadius.circular(999)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: isSel ? Colors.white : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(title, style: TextStyle(fontSize: 12, fontWeight: isSel ? FontWeight.w700 : FontWeight.w500, color: isSel ? Colors.white : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildPayPauseProtectionCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.shield_outlined, color: AppColors.info, size: 18),
          SizedBox(width: 8),
          Text('PayPause Protection Enabled', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textPrimary)),
        ]),
        const SizedBox(height: 6),
        Text('Wallet balances are protected with friction for transfers >₹2,500 after 11 PM.', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, height: 1.3)),
      ]),
    );
  }

  Widget _buildWalletHistory(AppProvider app) {
    final txs = app.transactions.take(4).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Recent Wallet Activity', style: AppTextStyles.title.copyWith(fontSize: 16)),
        Text('${txs.length} entries', style: AppTextStyles.caption),
      ]),
      const SizedBox(height: 8),
      ...txs.map((t) => Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.divider)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(t.counterpartyName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          Text('₹${t.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.brand)),
        ]),
      )),
    ]);
  }
}
