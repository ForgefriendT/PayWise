import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Rewards hero bento card with points balance matching Stitch Screen 17
class RewardsHeroCard extends StatelessWidget {
  final int points;

  const RewardsHeroCard({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final cashVal = points / 10.0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.brand, Color(0xFF4D1D82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.brand.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
                child: const Row(
                  children: [
                    Icon(Icons.stars, color: Colors.amber, size: 14),
                    SizedBox(width: 4),
                    Text('Gold Member • Level 3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const Row(
                children: [
                  Text('How to Earn', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  SizedBox(width: 2),
                  Icon(Icons.help_outline, color: Colors.white70, size: 14),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(points.toString(), style: AppTextStyles.display.copyWith(color: Colors.white, fontSize: 36)),
              const SizedBox(width: 6),
              Text('Pts', style: AppTextStyles.title.copyWith(color: Colors.white70, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            '${AppFormatters.formatRupee(cashVal)} equivalent cash value (10 Pts = ₹1)',
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 40),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.history, size: 16),
                  label: const Text('Points History', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.brand,
                    minimumSize: const Size(0, 40),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.auto_awesome, size: 16),
                  label: const Text('Boost Rewards', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
