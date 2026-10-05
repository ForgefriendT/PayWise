import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import 'paypause_logic.dart';
import 'paypause_ring_card.dart';

// Modal bottom sheet providing a 5-second reflection buffer before non-essential spending
class PayPauseSheet extends StatefulWidget {
  final PayPauseEvaluation eval;
  final VoidCallback onSkip;
  final VoidCallback onProceed;

  const PayPauseSheet({super.key, required this.eval, required this.onSkip, required this.onProceed});

  static Future<bool?> show(
    BuildContext context, {
    required PayPauseEvaluation eval,
    required VoidCallback onSkip,
    required VoidCallback onProceed,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PayPauseSheet(eval: eval, onSkip: onSkip, onProceed: onProceed),
    );
  }

  @override
  State<PayPauseSheet> createState() => _PayPauseSheetState();
}

class _PayPauseSheetState extends State<PayPauseSheet> {
  int _countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        setState(() => _countdown = 0);
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 36, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(99))),
          const SizedBox(height: 14),
          _buildHeader(),
          const SizedBox(height: 16),
          PayPauseRingCard(eval: widget.eval),
          const SizedBox(height: 12),
          _buildCallout(),
          const SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(color: AppColors.brandSoft, shape: BoxShape.circle),
          child: const Center(child: AppIcon('shield', size: 24, color: AppColors.brand)),
        ),
        const SizedBox(height: 8),
        Text('Take a 5-second PayPause', style: AppTextStyles.title),
        const SizedBox(height: 2),
        Text('Mindful spending guardrail triggered', style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildCallout() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFFEF6E6), borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppIcon('alert', size: 18, color: AppColors.warning),
          const SizedBox(width: 8),
          Expanded(child: Text(widget.eval.impactSentence, style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary))),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final canProceed = _countdown == 0;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandSoft,
              foregroundColor: AppColors.brand,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const AppIcon('trophy', size: 18, color: AppColors.brand),
            label: Text('Skip this one (save ${AppFormatters.formatRupee(widget.eval.amount)})', style: AppTextStyles.heading.copyWith(fontSize: 14)),
            onPressed: () { Navigator.of(context).pop(false); widget.onSkip(); },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: canProceed ? AppColors.brand : AppColors.divider,
              foregroundColor: canProceed ? Colors.white : AppColors.textSecondary,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: canProceed ? () { Navigator.of(context).pop(true); widget.onProceed(); } : null,
            child: Text(canProceed ? 'Pay anyway' : 'Pay anyway (${_countdown}s)', style: AppTextStyles.heading.copyWith(fontSize: 14)),
          ),
        ),
      ],
    );
  }
}
