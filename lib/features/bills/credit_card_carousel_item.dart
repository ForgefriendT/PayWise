import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../data/models/card_bill.dart';

// Metallic credit card preview item matching Stitch Screen 12
class CreditCardCarouselItem extends StatelessWidget {
  final CardBill card;

  const CreditCardCarouselItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final minDue = (card.dueAmount * 0.1).clamp(500.0, card.dueAmount);

    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E1233), Color(0xFF2F1B4E), Color(0xFF120B20)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(card.bank, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
            Text('Due in 4 days', style: TextStyle(color: AppColors.danger.withValues(alpha: 0.9), fontWeight: FontWeight.w700, fontSize: 11)),
          ]),
          Text('•••• ${card.last4}', style: const TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 3)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('TOTAL DUE', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text(AppFormatters.formatRupee(card.dueAmount), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
            ]),
            Text('Min: ${AppFormatters.formatRupee(minDue)}', style: const TextStyle(color: Colors.amberAccent, fontSize: 12)),
          ]),
        ],
      ),
    );
  }
}
