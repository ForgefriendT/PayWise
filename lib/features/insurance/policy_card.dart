import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Policy recommendation card matching Stitch Screen 15
class PolicyCard extends StatelessWidget {
  final String title;
  final String category;
  final String tag;
  final String icon;
  final Color iconColor;
  final String premium;
  final String feature1;
  final String feature2;
  final String trustNote;
  final VoidCallback onBuy;

  const PolicyCard({
    super.key,
    required this.title,
    required this.category,
    required this.tag,
    required this.icon,
    required this.iconColor,
    required this.premium,
    required this.feature1,
    required this.feature2,
    required this.trustNote,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(21)),
                    alignment: Alignment.center,
                    child: AppIcon(icon, size: 22, color: iconColor),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                            child: Text(tag, style: const TextStyle(color: AppColors.success, fontSize: 9, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      Text(category, style: AppTextStyles.caption.copyWith(fontSize: 11)),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Starting at', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                  Text(premium, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, color: AppColors.brand)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildBentoChip(Icons.verified_user_outlined, feature1)),
              const SizedBox(width: 8),
              Expanded(child: _buildBentoChip(Icons.local_hospital_outlined, feature2)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 14, color: AppColors.success),
                  const SizedBox(width: 4),
                  Text(trustNote, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, minimumSize: const Size(90, 36)),
                onPressed: onBuy,
                child: const Text('View Plan', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBentoChip(IconData iconData, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(iconData, size: 14, color: AppColors.brand),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary), maxLines: 1)),
        ],
      ),
    );
  }
}
