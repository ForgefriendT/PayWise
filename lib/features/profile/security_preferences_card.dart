import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Security and notification preferences card matching Stitch Screen 18
class SecurityPreferencesCard extends StatefulWidget {
  const SecurityPreferencesCard({super.key});

  @override
  State<SecurityPreferencesCard> createState() => _SecurityPreferencesCardState();
}

class _SecurityPreferencesCardState extends State<SecurityPreferencesCard> {
  bool _biometric = true;
  bool _alerts = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Security & Preferences', style: AppTextStyles.title.copyWith(fontSize: 15)),
          const SizedBox(height: 12),
          _buildToggleRow('Biometric Security', 'Face ID / Fingerprint lock', Icons.fingerprint, _biometric, (v) => setState(() => _biometric = v)),
          const Divider(height: 16, color: AppColors.divider),
          _buildToggleRow('Transaction Alerts', 'Instant Push and SMS', Icons.notifications_active_outlined, _alerts, (v) => setState(() => _alerts = v)),
          const Divider(height: 16, color: AppColors.divider),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN Reset link sent to +91 98765 43210')));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.background, shape: BoxShape.circle), child: const Icon(Icons.password, size: 16, color: AppColors.textPrimary)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reset UPI PIN', style: AppTextStyles.bodyBold.copyWith(fontSize: 12)),
                        const Text('Requires Debit card verification', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(String title, String sub, IconData icon, bool val, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.background, shape: BoxShape.circle), child: Icon(icon, size: 16, color: AppColors.textPrimary)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyBold.copyWith(fontSize: 12)),
                Text(sub, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
              ],
            ),
          ],
        ),
        Switch(value: val, activeTrackColor: AppColors.brand, onChanged: onChanged),
      ],
    );
  }
}
