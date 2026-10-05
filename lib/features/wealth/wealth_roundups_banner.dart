import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Mindful wealth roundups banner matching Stitch Screen 13
class WealthRoundupsBanner extends StatelessWidget {
  const WealthRoundupsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.brandSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: const AppIcon('flash', size: 20, color: AppColors.brand),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('PayWise Roundups', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text('Active', style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Spare Change Investing: ₹1,480 invested this month from rounded-up UPI payments.',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('Manage', style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
