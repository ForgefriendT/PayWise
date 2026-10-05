import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// History and spending analytics screen placeholder for M1
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Transaction History', style: AppTextStyles.title),
        backgroundColor: AppColors.surface,
      ),
      body: Center(
        child: Text(
          'History & Analytics Screen',
          style: AppTextStyles.heading.copyWith(color: AppColors.brand),
        ),
      ),
    );
  }
}
