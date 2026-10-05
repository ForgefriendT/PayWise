import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import 'add_money_sheet.dart';

// Wallet core balance card matching Stitch Screen 17
class WalletBalanceCard extends StatelessWidget {
  final double balance;

  const WalletBalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          Text('Available Liquid Balance', style: AppTextStyles.caption.copyWith(letterSpacing: 0.5)),
          const SizedBox(height: 2),
          Text(AppFormatters.formatRupee(balance), style: AppTextStyles.display.copyWith(fontSize: 30)),
          const SizedBox(height: 14),
          _buildLinkedAccounts(),
          const SizedBox(height: 14),
          _buildQuickPresets(context),
          const SizedBox(height: 14),
          _buildActionButtons(context),
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
              decoration: BoxDecoration(color: AppColors.brandSoft, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: const Icon(Icons.account_balance_wallet, color: AppColors.brand, size: 18),
            ),
            const SizedBox(width: 8),
            Text('PayWise Main Wallet', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
          child: const Row(
            children: [
              Icon(Icons.check_circle, size: 12, color: AppColors.success),
              SizedBox(width: 4),
              Text('KYC Verified', style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinkedAccounts() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('UPI Lite Reserve', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              Text('₹1,200.00', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: AppColors.textPrimary)),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Autofill Bank', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              Text('HDFC Bank ••9024', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPresets(BuildContext context) {
    const presets = [500.0, 1000.0, 2000.0, 5000.0];
    return Row(
      children: presets.map((p) {
        return Expanded(
          child: GestureDetector(
            onTap: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const AddMoneySheet()),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
              child: Text('+${AppFormatters.formatRupee(p)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, minimumSize: const Size(0, 46)),
            onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const AddMoneySheet()),
            icon: const Icon(Icons.add_circle_outline, size: 18, color: Colors.white),
            label: const Text('Add Money', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.divider), minimumSize: const Size(0, 46)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Withdrawal transfer of ₹2,000 initiated to HDFC ••9024!')));
            },
            icon: const Icon(Icons.arrow_outward, size: 18, color: AppColors.brand),
            label: const Text('Withdraw', style: TextStyle(color: AppColors.brand, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }
}
