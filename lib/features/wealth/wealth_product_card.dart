import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Reusable card container for investment product offerings matching Stitch Screen 13
class WealthProductCard extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final String title;
  final String badge;
  final Color badgeBg;
  final Color badgeColor;
  final String subtitle;
  final String infoLeft;
  final String infoRight;
  final Widget action;

  const WealthProductCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.badge,
    required this.badgeBg,
    required this.badgeColor,
    required this.subtitle,
    required this.infoLeft,
    required this.infoRight,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: AppIcon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(999)),
                        child: Text(badge, style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(infoLeft, style: AppTextStyles.caption.copyWith(fontSize: 11)),
                Text(infoRight, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, fontSize: 11, color: AppColors.textPrimary)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          action,
        ],
      ),
    );
  }
}
