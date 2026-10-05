import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Pre-approved loan offer gradient hero banner matching Stitch Screen 16
class PreApprovedBanner extends StatelessWidget {
  const PreApprovedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.brand, Color(0xFF714BA4)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
                child: const Text('PRE-APPROVED OFFER', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
              ),
              const Icon(Icons.bolt, color: Colors.amber, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text('Up to ₹5,00,000', style: AppTextStyles.title.copyWith(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 4),
          Text('Zero paperwork • Instant disbursement to HDFC Bank ••9024', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11)),
        ],
      ),
    );
  }
}
