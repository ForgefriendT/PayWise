import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/app_provider.dart';
import '../features/auth/login_screen.dart';
import '../features/bills/bills_screen.dart';
import '../features/bills/credit_card_bill_screen.dart';
import '../features/history/history_screen.dart';
import '../features/home/home_screen.dart';
import '../features/home/nav_shell.dart';
import '../features/pay/contacts_screen.dart';
import '../features/pay/pay_screen.dart';
import '../features/pay/scan_screen.dart';
import '../features/insurance/insurance_screen.dart';
import '../features/lending/lending_screen.dart';
import '../features/wallet/rewards_screen.dart';
import '../features/wealth/digital_gold_screen.dart';
import '../features/wealth/wealth_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Creates the application GoRouter with dynamic authentication redirects
GoRouter createRouter(AppProvider provider) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: provider,
    redirect: (context, state) {
      final loggedIn = provider.authUser != null;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!loggedIn && !isLoggingIn) return '/login';
      if (loggedIn && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/wealth', builder: (context, state) => const WealthScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/services', builder: (context, state) => const BillsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/rewards', builder: (context, state) => const RewardsScreen()),
          ]),
        ],
      ),
      GoRoute(
        path: '/scan',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ScanScreen(),
      ),
      GoRoute(
        path: '/contacts',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ContactsScreen(),
      ),
      GoRoute(
        path: '/pay',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final name = extra['name'] as String? ?? (state.uri.queryParameters['name'] ?? 'Recipient');
          final upi = extra['upiId'] as String? ?? (state.uri.queryParameters['upi'] ?? 'recipient@okhdfcbank');
          final amount = extra['amount'] as double? ?? (double.tryParse(state.uri.queryParameters['amount'] ?? '') ?? 0.0);
          return PayScreen(name: name, upiId: upi, initialAmount: amount);
        },
      ),
      GoRoute(
        path: '/bills',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const BillsScreen(),
      ),
      GoRoute(
        path: '/credit-card-bill',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CreditCardBillScreen(),
      ),
      GoRoute(
        path: '/gold',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const DigitalGoldScreen(),
      ),
      GoRoute(
        path: '/insurance',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const InsuranceScreen(),
      ),
      GoRoute(
        path: '/lending',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LendingScreen(),
      ),
      GoRoute(
        path: '/wallet',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RewardsScreen(),
      ),
    ],
  );
}
