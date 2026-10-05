import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/router.dart';
import 'core/theme/app_theme.dart';
import 'data/app_provider.dart';
import 'firebase_options.dart';

// Entry point of the PayWise application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const PayWiseApp(),
    ),
  );
}

// Root application widget configuring theme and GoRouter
class PayWiseApp extends StatefulWidget {
  const PayWiseApp({super.key});

  @override
  State<PayWiseApp> createState() => _PayWiseAppState();
}

class _PayWiseAppState extends State<PayWiseApp> {
  late final appRouter = createRouter(context.read<AppProvider>());

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
