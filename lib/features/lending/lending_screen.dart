import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import 'loan_customizer_card.dart';
import 'loan_product_card.dart';
import 'pre_approved_banner.dart';

// Lending and loan eligibility screen matching Stitch Screen 16
class LendingScreen extends StatefulWidget {
  const LendingScreen({super.key});

  @override
  State<LendingScreen> createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen> {
  double _income = 65000.0;
  double _loanAmount = 200000.0;
  int _tenureMonths = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Loan Eligibility & EMI', style: AppTextStyles.title.copyWith(fontSize: 18)),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PreApprovedBanner(),
            const SizedBox(height: 12),
            _buildIncomeCard(),
            const SizedBox(height: 14),
            LoanCustomizerCard(
              loanAmount: _loanAmount,
              tenureMonths: _tenureMonths,
              monthlyIncome: _income,
              onAmountChanged: (v) => setState(() => _loanAmount = v),
              onTenureChanged: (m) => setState(() => _tenureMonths = m),
            ),
            const SizedBox(height: 14),
            _buildCuratedHeader(),
            const SizedBox(height: 8),
            _buildProducts(),
            const SizedBox(height: 14),
            _buildBureauTransparencyStrip(),
            const SizedBox(height: 16),
            _buildApplyButton(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Monthly In-Hand Income', style: AppTextStyles.caption),
              Text(AppFormatters.formatRupee(_income), style: AppTextStyles.title.copyWith(fontSize: 18, color: AppColors.brand)),
            ],
          ),
          Slider(
            value: _income,
            min: 25000.0,
            max: 200000.0,
            divisions: 35,
            activeColor: AppColors.brand,
            onChanged: (v) => setState(() => _income = v),
          ),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('₹25,000', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
            Text('₹2,00,000+', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
          ]),
        ],
      ),
    );
  }

  Widget _buildCuratedHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Curated Credit Solutions', style: AppTextStyles.title.copyWith(fontSize: 16)),
        Text('Explore All', style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildProducts() {
    return Column(
      children: [
        LoanProductCard(title: 'Instant Cash Loan', badge: 'Fastest', subtitle: 'Up to ₹5,00,000 • 10.5% p.a. • 2 min approval', icon: Icons.electric_bolt, iconColor: AppColors.brand, onTap: () {}),
        const SizedBox(height: 8),
        LoanProductCard(title: 'PayWise Credit Line', subtitle: 'Pay interest only on withdrawn cash • ₹0 fee', icon: Icons.credit_card, iconColor: AppColors.warning, onTap: () {}),
        const SizedBox(height: 8),
        LoanProductCard(title: 'Gold Loan at Doorstep', subtitle: '8.5% p.a. • Doorstep valuation & instant transfer', icon: Icons.shield, iconColor: AppColors.info, onTap: () {}),
      ],
    );
  }

  Widget _buildBureauTransparencyStrip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: const Row(
        children: [
          Icon(Icons.verified_user_outlined, size: 16, color: AppColors.info),
          SizedBox(width: 8),
          Expanded(child: Text('Bureau score impact: Zero for checking eligibility. Safe & 256-bit encrypted.', style: TextStyle(color: AppColors.textSecondary, fontSize: 11))),
        ],
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, minimumSize: const Size(double.infinity, 50)),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Instant Pre-Approval for ${AppFormatters.formatRupee(_loanAmount)} sanctioned!')));
      },
      child: Text('Apply for ${AppFormatters.formatRupee(_loanAmount)} Loan Now', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
    );
  }
}
