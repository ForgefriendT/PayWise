import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import 'claim_milestone_tracker.dart';

// Hero claim tracker card matching Stitch Screen 15
class ClaimTrackerCard extends StatelessWidget {
  final int step;
  final VoidCallback onAdvance;

  const ClaimTrackerCard({super.key, required this.step, required this.onAdvance});

  @override
  Widget build(BuildContext context) {
    const statusLabels = ['Submitted', 'Under Review', 'Approved', 'Disbursed'];
    final currentLabel = statusLabels[(step - 1).clamp(0, 3)];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(currentLabel),
          const SizedBox(height: 14),
          _buildHospitalMeta(),
          const SizedBox(height: 16),
          ClaimMilestoneTracker(currentStep: step),
          const SizedBox(height: 16),
          _buildTpaBanner(),
          const SizedBox(height: 14),
          _buildActionRow(context),
        ],
      ),
    );
  }

  Widget _buildHeader(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: AppColors.danger.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              child: const AppIcon('heart-pulse', size: 20, color: AppColors.danger),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Claim #CLM-894102', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                Text('Health Shield Comprehensive', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
          child: Text(label, style: const TextStyle(color: AppColors.warning, fontSize: 10, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  Widget _buildHospitalMeta() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hospital & Location', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              Text('Manipal Hospital, Bangalore', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Claimed Amount', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              Text(AppFormatters.formatRupee(45000), style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, color: AppColors.brand)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTpaBanner() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 16, color: AppColors.brand),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'TPA document verification in final stage. Expected resolution: within 24 hours.',
              style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onAdvance,
          child: Row(
            children: [
              Text(step < 4 ? 'Advance Step (Demo)' : 'Claim Completed', style: TextStyle(color: AppColors.brand, fontWeight: FontWeight.w700, fontSize: 12)),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward, size: 14, color: AppColors.brand),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.background, foregroundColor: AppColors.textPrimary, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6)),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Uploaded medical bills and discharge summary!')));
          },
          child: const Text('Upload Files', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
