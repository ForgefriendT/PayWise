import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Overview summary strip for upcoming bills matching Stitch Screen 10
class BillsSummaryStrip extends StatelessWidget {
  final int count;
  final double total;

  const BillsSummaryStrip({super.key, required this.count, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: AppColors.brand, shape: BoxShape.circle),
                child: const Center(child: AppIcon('bell', size: 16, color: Colors.white)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$count Bills due this week', style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
                  Text('Total payable: ${AppFormatters.formatRupee(total)}', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppColors.brand, borderRadius: BorderRadius.circular(999)),
            child: const Text('PROTECTED', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
