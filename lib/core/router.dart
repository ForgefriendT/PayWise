import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/bills/bills_screen.dart';
import '../features/history/history_screen.dart';
import '../features/home/home_screen.dart';
import '../features/home/nav_shell.dart';
import '../features/pay/scan_screen.dart';
import '../features/wallet/rewards_screen.dart';
import '../features/wealth/wealth_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Application routing table using GoRouter
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
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
  ],
);
