import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';

// Scratch cards waiting banner matching Stitch Screen 17
class ScratchCardsBanner extends StatelessWidget {
  const ScratchCardsBanner({super.key});

  void _openScratchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.redeem, color: AppColors.brand, size: 24),
            SizedBox(width: 8),
            Text('Mystery Scratch Card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.amber, Colors.deepOrange]),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.celebration, color: Colors.white, size: 36),
                  SizedBox(height: 6),
                  Text('You won 75 Points!', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text('Added instantly to your PayWise reward balance.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand),
            onPressed: () async {
              final app = ctx.read<AppProvider>();
              final uid = app.authUser?.uid;
              final user = app.userProfile;
              if (uid != null && user != null) {
                await app.firestoreService.updateUser(uid, {'rewardPoints': user.rewardPoints + 75});
              }
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Claim Reward', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: const Icon(Icons.redeem, color: AppColors.brand, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2 Scratch Cards Waiting', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 2),
                Text('From your recent Grocery & UPI bills', style: AppTextStyles.caption.copyWith(fontSize: 11)),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandSoft, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
            onPressed: () => _openScratchDialog(context),
            icon: const Icon(Icons.touch_app, size: 14, color: AppColors.brand),
            label: const Text('Scratch', style: TextStyle(color: AppColors.brand, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
