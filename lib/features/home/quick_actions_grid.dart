import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// 4x2 quick actions grid matching Stitch Screen 02
class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': 'scan', 'label': 'Scan QR', 'route': '/scan', 'primary': true},
      {'icon': 'send', 'label': 'Send', 'route': '/contacts', 'primary': false},
      {'icon': 'qr', 'label': 'UPI ID', 'route': '/contacts', 'primary': false},
      {'icon': 'bank', 'label': 'To Bank', 'route': '/contacts', 'primary': false},
      {'icon': 'mobile', 'label': 'Recharge', 'route': '/services', 'primary': false},
      {'icon': 'bill', 'label': 'Pay Bills', 'route': '/services', 'primary': false},
      {'icon': 'wallet', 'label': 'Self Xfer', 'route': '/rewards', 'primary': false},
      {'icon': 'services', 'label': 'More', 'route': '/services', 'primary': false},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 0.85,
        ),
        itemCount: actions.length,
        itemBuilder: (context, i) {
          final a = actions[i];
          final isPrimary = a['primary'] as bool;

          return GestureDetector(
            onTap: () => context.push(a['route'] as String),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isPrimary ? AppColors.brand : AppColors.brandSoft,
                    shape: BoxShape.circle,
                    boxShadow: isPrimary
                        ? [BoxShadow(color: AppColors.brand.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))]
                        : null,
                  ),
                  child: Center(
                    child: AppIcon(
                      a['icon'] as String,
                      size: 22,
                      color: isPrimary ? Colors.white : AppColors.brand,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  a['label'] as String,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 11,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
