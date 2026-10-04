import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/colors.dart';
import 'core/theme/text_styles.dart';

// Entry point of the PayWise application
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PayWiseApp());
}

// Root application widget configuring theme and home screen
class PayWiseApp extends StatelessWidget {
  const PayWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayWise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const BlankThemedScreen(),
    );
  }
}

// Initial placeholder screen verifying theme application
class BlankThemedScreen extends StatelessWidget {
  const BlankThemedScreen({super.key});

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
          'PayWise Initialized',
          style: AppTextStyles.heading.copyWith(color: AppColors.brand),
        ),
      ),
    );
  }
}
