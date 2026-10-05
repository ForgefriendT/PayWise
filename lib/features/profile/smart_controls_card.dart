import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Smart budgeting controls & simulation switches card matching Stitch Screen 18
class SmartControlsCard extends StatelessWidget {
  final bool paypauseOn;
  final bool simulateFailure;
  final ValueChanged<bool> onPaypauseToggle;
  final ValueChanged<bool> onSimulateFailureToggle;

  const SmartControlsCard({
    super.key,
    required this.paypauseOn,
    required this.simulateFailure,
    required this.onPaypauseToggle,
    required this.onSimulateFailureToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.psychology_alt, color: AppColors.brand, size: 18),
              ),
              const SizedBox(width: 8),
              Text('Smart Budgeting & Controls', style: AppTextStyles.title.copyWith(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 14),
          _buildSwitchRow(
            'PayPause™ Guard',
            'ACTIVE',
            '5-second mindfulness check when purchase exceeds envelope budget.',
            paypauseOn,
            onPaypauseToggle,
            badgeColor: AppColors.brand,
          ),
          const SizedBox(height: 12),
          _buildEnvelopesChipRow(),
          const SizedBox(height: 12),
          _buildSwitchRow(
            'Simulate Payment Failure',
            'DEBUG',
            'Triggers bank timeout simulation and immediate sandbox refund.',
            simulateFailure,
            onSimulateFailureToggle,
            badgeColor: AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(String title, String badge, String sub, bool val, ValueChanged<bool> onChanged, {required Color badgeColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title, style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(color: badgeColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                    child: Text(badge, style: TextStyle(color: badgeColor, fontSize: 9, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(sub, style: AppTextStyles.caption.copyWith(fontSize: 11, height: 1.25)),
            ],
          ),
        ),
        Switch(
          value: val,
          activeTrackColor: AppColors.brand,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildEnvelopesChipRow() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.pie_chart_outline, size: 14, color: AppColors.brand),
                  SizedBox(width: 4),
                  Text('Category Envelopes', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
                ],
              ),
              Text('Monthly Budgets', style: AppTextStyles.caption.copyWith(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildChip('Food: ₹4,000'),
              const SizedBox(width: 6),
              _buildChip('Shopping: ₹8,000'),
              const SizedBox(width: 6),
              _buildChip('Travel: ₹5,000'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.divider)),
      child: Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
    );
  }
}
