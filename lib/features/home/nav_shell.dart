import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'nav_bottom_bar.dart';

// Navigation shell matching Stitch Screen 02 with 5 tabs and a raised center Scan action
class NavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavBottomBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
            onScan: () => context.push('/scan'),
          ),
        ),
      ),
    );
  }
}
