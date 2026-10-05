import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// PayWise bill protection gradient banner matching Stitch Screen 10
class BillProtectionBanner extends StatelessWidget {
  const BillProtectionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.brand, AppColors.brandDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: const Center(child: AppIcon('shield', size: 20, color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PayWise Bill Protection', style: AppTextStyles.bodyBold.copyWith(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 2),
                Text(
                  'Never miss a penalty fee with AI calendar sync & 1-tap recurring UPI mandates with 0% gateway charges.',
                  style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.85), fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
