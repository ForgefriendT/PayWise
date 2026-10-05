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
          GestureDetector(
            onTap: () => context.push('/rewards'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.divider),
                boxShadow: const [
                  BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
                ],
              ),
              child: Row(
                children: [
                  const AppIcon('wallet', size: 18, color: AppColors.brand),
                  const SizedBox(width: 6),
                  Text(
                    AppFormatters.formatRupee(walletBalance),
                    style: AppTextStyles.bodyBold.copyWith(fontSize: 14, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
