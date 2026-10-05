import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import 'qr_preview_dialog.dart';

// User profile hero card matching Stitch Screen 18
class ProfileHeroCard extends StatelessWidget {
  final String name;
  final String upiId;

  const ProfileHeroCard({super.key, required this.name, required this.upiId});

  @override
  Widget build(BuildContext context) {
    final initials = name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(color: AppColors.brandSoft, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(initials.isEmpty ? 'FB' : initials, style: AppTextStyles.title.copyWith(fontSize: 20, color: AppColors.brand)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.title.copyWith(fontSize: 18)),
                    const SizedBox(height: 2),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: upiId));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('UPI ID copied to clipboard!')));
                      },
                      child: Row(
                        children: [
                          Text(upiId, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                          const SizedBox(width: 4),
                          const Icon(Icons.copy, size: 12, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                      decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, size: 12, color: AppColors.success),
                          SizedBox(width: 3),
                          Text('Full KYC Verified', style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.smartphone, size: 16, color: AppColors.textSecondary),
                    SizedBox(width: 6),
                    Text('+91 98765 43210', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  ],
                ),
                GestureDetector(
                  onTap: () => QrPreviewDialog.show(context, name, upiId),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.divider)),
                    child: const Row(
                      children: [
                        Icon(Icons.qr_code_2, size: 14, color: AppColors.brand),
                        SizedBox(width: 4),
                        Text('My QR', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.brand)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
