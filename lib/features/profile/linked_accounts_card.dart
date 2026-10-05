import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Linked payment bank accounts card matching Stitch Screen 18
class LinkedAccountsCard extends StatelessWidget {
  const LinkedAccountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Linked Payment Accounts', style: AppTextStyles.title.copyWith(fontSize: 15)),
              const Text('2 Active', style: TextStyle(color: AppColors.brand, fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 12),
          _buildBankItem('HDFC Bank', 'Savings ••9024', true, () {}),
          const SizedBox(height: 8),
          _buildBankItem('State Bank of India', 'Savings ••4019', false, () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('State Bank of India set as primary account!')));
          }),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.divider), minimumSize: const Size(double.infinity, 42)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bank discovery & account addition simulated!')));
            },
            icon: const Icon(Icons.add_circle_outline, size: 16, color: AppColors.brand),
            label: const Text('Add Bank Account / RuPay Card', style: TextStyle(color: AppColors.brand, fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildBankItem(String bank, String account, bool isDefault, VoidCallback onSetPrimary) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.account_balance, size: 18, color: AppColors.brand),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(bank, style: AppTextStyles.bodyBold.copyWith(fontSize: 12)),
                      if (isDefault) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(4)),
                          child: const Text('DEFAULT', style: TextStyle(color: AppColors.brand, fontSize: 9, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ],
                  ),
                  Text(account, style: AppTextStyles.caption.copyWith(fontSize: 11)),
                ],
              ),
            ],
          ),
          if (isDefault)
            const Icon(Icons.check_circle, size: 18, color: AppColors.success)
          else
            GestureDetector(
              onTap: onSetPrimary,
              child: const Text('Set Primary', style: TextStyle(color: AppColors.brand, fontSize: 11, fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }
}
