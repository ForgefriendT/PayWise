import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/app_provider.dart';
import '../../data/models/bill.dart';
import 'autopay_sheet.dart';
import 'bill_categories_grid.dart';
import 'bill_protection_banner.dart';
import 'bills_summary_strip.dart';
import 'recent_bill_receipts.dart';
import 'saved_bills_list.dart';

// Bills and utility hub screen matching Stitch Screen 10
class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onAutopaySetup(Bill bill) {
    AutopaySheet.show(context, bill, (limit, days) async {
      final app = context.read<AppProvider>();
      final uid = app.authUser?.uid;
      if (uid != null) {
        await app.firestoreService.updateBill(uid, bill.id, {'autopay': true, 'autopayMax': limit, 'reminderDays': days});
      }
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Autopay activated for ${bill.provider}!')));
    });
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final bills = app.bills;
    final totalDue = bills.fold(0.0, (s, b) => s + b.amount);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(const Duration(milliseconds: 500)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 12),
              BillsSummaryStrip(count: bills.length, total: totalDue > 0 ? totalDue : 2419),
              const SizedBox(height: 16),
              const BillCategoriesGrid(),
              const SizedBox(height: 20),
              SavedBillsList(
                bills: bills,
                onAutopayTap: _onAutopaySetup,
                onPayNowTap: (b) => context.push('/pay', extra: {'name': b.provider, 'upiId': '${b.category}@paywise', 'amount': b.amount}),
              ),
              const SizedBox(height: 20),
              const BillProtectionBanner(),
              const SizedBox(height: 20),
              RecentBillReceipts(transactions: app.transactions),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PAYWISE', style: AppTextStyles.caption.copyWith(fontSize: 10, letterSpacing: 1.2)),
          Text('Bills & Utilities', style: AppTextStyles.heading.copyWith(fontSize: 16)),
        ],
      ),
      actions: [
        IconButton(icon: const AppIcon('bell', size: 20, color: AppColors.textSecondary), onPressed: () {}),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchCtrl,
      decoration: InputDecoration(
        hintText: 'Search provider, biller, or ID...',
        filled: true,
        fillColor: AppColors.surface,
        prefixIcon: const Padding(padding: EdgeInsets.all(12), child: AppIcon('search', size: 16, color: AppColors.textSecondary)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.divider)),
      ),
    );
  }
}
