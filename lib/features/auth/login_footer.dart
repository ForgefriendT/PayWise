import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Footer information and compliance disclaimer for Login screen
class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppIcon('alert', size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'Demo mode - simulated fintech platform',
                style: AppTextStyles.caption,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Privacy Protocol • Security Audited • v2.4.0',
          style: AppTextStyles.caption.copyWith(fontSize: 11, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
