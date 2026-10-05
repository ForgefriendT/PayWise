import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/app_provider.dart';
import 'bills_due_strip.dart';
import 'home_header.dart';
import 'home_stat_cards.dart';
import 'paypause_summary_card.dart';
import 'quick_actions_grid.dart';
import 'recent_transactions_list.dart';

// Home dashboard screen matching Stitch Screen 02
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final profile = app.userProfile;
    final name = profile?.name.split(' ').first ?? 'Fauzan';
    final balance = profile?.walletBalance ?? 14500.0;
    final pendingBill = app.bills.isNotEmpty ? app.bills.first : null;
    final saved = app.pauses.fold<double>(0.0, (s, p) => s + p.amount);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(const Duration(milliseconds: 600)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(name: name, walletBalance: balance),
              const QuickActionsGrid(),
              HomeStatCards(
                successRate: 98.4,
                cashback: profile?.cashbackTotal ?? 240.0,
                rewardPoints: profile?.rewardPoints ?? 1250,
              ),
              PayPauseSummaryCard(
                savedAmount: saved > 0 ? saved : 4200.0,
                pauseCount: app.pauses.isNotEmpty ? app.pauses.length : 3,
                onInsightsTap: () => context.push('/history'),
              ),
              if (pendingBill != null)
                BillsDueStrip(
                  bill: pendingBill,
                  onPay: () => context.push('/bills'),
                ),
              RecentTransactionsList(
                transactions: app.transactions,
                onSeeAllTap: () => context.push('/history'),
                onTransactionTap: (tx) => context.push('/history'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.brand,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: AppIcon('shield', size: 18, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'PayWise',
            style: AppTextStyles.title.copyWith(
              color: AppColors.brand,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const AppIcon('bell', size: 22, color: AppColors.textPrimary),
          onPressed: () {},
        ),
        GestureDetector(
          onTap: () => context.push('/profile'),
          child: Container(
            margin: const EdgeInsets.only(right: 16, left: 4),
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.brand,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: AppIcon('user', size: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
