import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Brand header for the login screen matching Stitch design
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.brandSoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: AppIcon('wallet', size: 34, color: AppColors.brand),
              ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('PayWise', style: AppTextStyles.display.copyWith(fontSize: 26)),
        const SizedBox(height: 4),
        Text('Smart, calm payments', style: AppTextStyles.caption.copyWith(fontSize: 14)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppIcon('flash', size: 14, color: AppColors.brand),
              const SizedBox(width: 6),
              Text(
                'Mindful spending active',
                style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
