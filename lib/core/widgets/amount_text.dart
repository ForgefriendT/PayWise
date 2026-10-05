import 'package:flutter/material.dart';
import '../formatters.dart';
import '../theme/text_styles.dart';

// Displays formatted currency with optional count-up animation
class AmountText extends StatelessWidget {
  final num amount;
  final TextStyle? style;
  final bool animate;
  final Duration duration;

  const AmountText({
    super.key,
    required this.amount,
    this.style,
    this.animate = false,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? AppTextStyles.title;

    if (!animate) {
      return Text(
        AppFormatters.formatRupee(amount),
        style: effectiveStyle,
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: amount.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Text(
          AppFormatters.formatRupee(value.round()),
          style: effectiveStyle,
        );
      },
    );
  }
}
