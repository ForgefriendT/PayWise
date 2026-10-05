import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// QR Code scanner screen placeholder for M1
class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Scan QR Code', style: AppTextStyles.title),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const AppIcon('close', size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Text(
          'QR Scanner Screen',
          style: AppTextStyles.heading.copyWith(color: AppColors.brand),
        ),
      ),
    );
  }
}
