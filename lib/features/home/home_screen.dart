import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Home dashboard screen placeholder for M1
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('PayWise', style: AppTextStyles.title),
        backgroundColor: AppColors.surface,
      ),
      body: Center(
        child: Text(
          'Home Screen',
          style: AppTextStyles.heading.copyWith(color: AppColors.brand),
        ),
      ),
    );
  }
}
