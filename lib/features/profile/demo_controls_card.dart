import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';

// Demo reload and sign-out controls matching Stitch Screen 18
class DemoControlsCard extends StatefulWidget {
  const DemoControlsCard({super.key});

  @override
  State<DemoControlsCard> createState() => _DemoControlsCardState();
}

class _DemoControlsCardState extends State<DemoControlsCard> {
  bool _loading = false;

  Future<void> _handleReload() async {
    setState(() => _loading = true);
    try {
      await context.read<AppProvider>().reloadDemoData();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo data successfully reloaded in Firestore!')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.terminal, color: AppColors.brand, size: 18)),
              const SizedBox(width: 8),
              Text('Demo & Sandbox Controls', style: AppTextStyles.title.copyWith(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Reset client mocks to default test transactions, category progress budgets, and simulated envelope allocations.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 11, height: 1.3),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.background, foregroundColor: AppColors.textPrimary, minimumSize: const Size(double.infinity, 44), elevation: 0),
            onPressed: _loading ? null : _handleReload,
            icon: _loading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.refresh, size: 18),
            label: const Text('Reload Demo Data', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          ),
          const SizedBox(height: 14),
          const Center(child: Text('PayWise Simulated Fintech Prototype v1.0.4', style: TextStyle(color: AppColors.textSecondary, fontSize: 11))),
          const SizedBox(height: 12),
          TextButton.icon(
            style: TextButton.styleFrom(minimumSize: const Size(double.infinity, 42), foregroundColor: AppColors.danger),
            onPressed: () => context.read<AppProvider>().authService.signOut(),
            icon: const Icon(Icons.logout, size: 18),
            label: const Text('Sign Out of Account', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
