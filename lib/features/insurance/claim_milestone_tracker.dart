import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// 4-step milestone claim tracker matching Stitch Screen 15
class ClaimMilestoneTracker extends StatelessWidget {
  final int currentStep; // 1 to 4
  final VoidCallback? onAdvanceStep;

  const ClaimMilestoneTracker({super.key, required this.currentStep, this.onAdvanceStep});

  @override
  Widget build(BuildContext context) {
    const steps = [
      {'title': 'Submitted', 'date': '24 Oct'},
      {'title': 'Review', 'date': '25 Oct'},
      {'title': 'Approved', 'date': 'Pending'},
      {'title': 'Disbursed', 'date': 'Pending'},
    ];

    final progressRatio = ((currentStep - 1) / 3.0).clamp(0.0, 1.0);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 14,
              left: 24,
              right: 24,
              child: Container(
                height: 4,
                decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progressRatio,
                  child: Container(decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(2))),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(steps.length, (idx) {
                final isDone = idx < currentStep - 1;
                final isCurrent = idx == currentStep - 1;
                return _buildStepNode(idx + 1, steps[idx]['title']!, steps[idx]['date']!, isDone, isCurrent);
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepNode(int stepNum, String title, String date, bool isDone, bool isCurrent) {
    Color circleColor;
    Widget icon;

    if (isDone) {
      circleColor = AppColors.success;
      icon = const Icon(Icons.check, size: 16, color: Colors.white);
    } else if (isCurrent) {
      circleColor = AppColors.warning;
      icon = const Icon(Icons.hourglass_top, size: 16, color: Colors.white);
    } else {
      circleColor = AppColors.divider;
      icon = Text('$stepNum', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary));
    }

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: icon,
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
            color: isCurrent ? AppColors.warning : (isDone ? AppColors.textPrimary : AppColors.textSecondary),
            fontSize: 11,
          ),
        ),
        Text(date, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }
}
