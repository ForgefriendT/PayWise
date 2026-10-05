import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';
import 'demo_controls_card.dart';
import 'linked_accounts_card.dart';
import 'profile_hero_card.dart';
import 'security_preferences_card.dart';
import 'smart_controls_card.dart';

// Profile and settings screen matching Stitch Screen 18
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final user = app.userProfile;
    final name = user?.name ?? 'Fauzan Baig';
    final upiId = user?.upiId ?? 'fauzan@paywise';
    final paypauseOn = user?.paypauseOn ?? true;
    final simFailure = user?.simulateFailure ?? false;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SCREEN 18: PROFILE & CONTROLS', style: AppTextStyles.caption.copyWith(fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w700)),
            Text('Profile & Settings', style: AppTextStyles.title.copyWith(fontSize: 18)),
          ],
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                ProfileHeroCard(name: name, upiId: upiId),
                const SizedBox(height: 12),
                SmartControlsCard(
                  paypauseOn: paypauseOn,
                  simulateFailure: simFailure,
                  onPaypauseToggle: (v) {
                    final uid = app.authUser?.uid;
                    if (uid != null) app.firestoreService.updateUser(uid, {'paypauseOn': v});
                  },
                  onSimulateFailureToggle: (v) {
                    final uid = app.authUser?.uid;
                    if (uid != null) app.firestoreService.updateUser(uid, {'simulateFailure': v});
                  },
                ),
                const SizedBox(height: 12),
                const LinkedAccountsCard(),
                const SizedBox(height: 12),
                const SecurityPreferencesCard(),
                const SizedBox(height: 12),
                const DemoControlsCard(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
