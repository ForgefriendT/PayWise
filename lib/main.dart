import 'package:flutter/material.dart';
import 'core/router.dart';
import 'core/theme/app_theme.dart';

// Entry point of the PayWise application
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PayWiseApp());
}

// Root application widget configuring theme and GoRouter
class PayWiseApp extends StatelessWidget {
  const PayWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PayWise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
