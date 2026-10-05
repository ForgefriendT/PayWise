import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

// Animated radial progress ring depicting budget impact before and after payment
class MonthImpactRing extends StatelessWidget {
  final double currentPercent;
  final double projectedPercent;
  final Color alertColor;
  final double size;

  const MonthImpactRing({
    super.key,
    required this.currentPercent,
    required this.projectedPercent,
    required this.alertColor,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: currentPercent, end: projectedPercent),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _RingPainter(
                  currentPercent: currentPercent,
                  animatedPercent: animatedValue,
                  alertColor: alertColor,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('BUDGET', style: AppTextStyles.caption.copyWith(fontSize: 10, letterSpacing: 1.2)),
                  Text(
                    '${animatedValue.round()}%',
                    style: AppTextStyles.display.copyWith(fontSize: 28, height: 1.1),
                  ),
                  Text(
                    animatedValue > 100 ? 'Over Limit' : 'Approaching Cap',
                    style: AppTextStyles.caption.copyWith(
                      color: alertColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double currentPercent;
  final double animatedPercent;
  final Color alertColor;

  _RingPainter({
    required this.currentPercent,
    required this.animatedPercent,
    required this.alertColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16) / 2;
    const strokeWidth = 10.0;
    const startAngle = -pi / 2;

    // Track circle
    final trackPaint = Paint()
      ..color = AppColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    // Current spend arc
    final currentSweep = (currentPercent.clamp(0, 100) / 100) * 2 * pi;
    final currentPaint = Paint()
      ..color = AppColors.brand.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      currentSweep,
      false,
      currentPaint,
    );

    // Projected spend arc (escalation in amber/red)
    final animatedSweep = (animatedPercent.clamp(0, 120) / 100) * 2 * pi;
    final projectedPaint = Paint()
      ..color = alertColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + currentSweep,
      max(0, animatedSweep - currentSweep),
      false,
      projectedPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.animatedPercent != animatedPercent;
}
