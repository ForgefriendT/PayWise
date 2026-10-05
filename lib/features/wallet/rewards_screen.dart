import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Rewards and redemption catalog screen placeholder for M1
class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Rewards & Cashback', style: AppTextStyles.title),
        backgroundColor: AppColors.surface,
      ),
      body: Center(
        child: Text(
          'Rewards Screen',
          style: AppTextStyles.heading.copyWith(color: AppColors.brand),
        ),
      ),
    );
  }
}
