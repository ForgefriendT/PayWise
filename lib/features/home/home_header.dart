import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Home top header matching Stitch Screen 02 with balance pill and alerts
class HomeHeader extends StatelessWidget {
  final String name;
  final double walletBalance;

  const HomeHeader({super.key, required this.name, required this.walletBalance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi, $name', style: AppTextStyles.title.copyWith(fontSize: 20)),
              Text('Welcome back', style: AppTextStyles.caption),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => context.push('/rewards'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    children: [
                      const AppIcon('wallet', size: 16, color: AppColors.brand),
                      const SizedBox(width: 6),
                      Text(
                        AppFormatters.formatRupee(walletBalance),
                        style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.divider),
                ),
                child: const Center(child: AppIcon('bell', size: 18, color: AppColors.textPrimary)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
