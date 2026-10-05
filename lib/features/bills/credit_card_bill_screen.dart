import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/formatters.dart';
import '../../core/pricing_rules.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/app_provider.dart';
import '../../data/models/card_bill.dart';
import '../pay/success_screen.dart';
import 'credit_card_carousel_item.dart';

// Credit card bill payment screen matching Stitch Screen 12 with 1% pricing rule
class CreditCardBillScreen extends StatefulWidget {
  const CreditCardBillScreen({super.key});

  @override
  State<CreditCardBillScreen> createState() => _CreditCardBillScreenState();
}

class _CreditCardBillScreenState extends State<CreditCardBillScreen> {
  final int _cardIndex = 0;
  String _mode = 'total';
  bool _paying = false;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cards = app.cards.isNotEmpty
        ? app.cards
        : [
            CardBill(id: 'c1', bank: 'HDFC Regalia Gold', last4: '4028', dueAmount: 9800, dueDate: DateTime(2026, 10, 30)),
            CardBill(id: 'c2', bank: 'ICICI Coral Rupay', last4: '8831', dueAmount: 4500, dueDate: DateTime(2026, 11, 4)),
          ];
    final activeCard = cards[_cardIndex.clamp(0, cards.length - 1)];
    final minDue = (activeCard.dueAmount * 0.1).clamp(500.0, activeCard.dueAmount);
    final billAmount = _mode == 'total' ? activeCard.dueAmount : minDue;
    final fee = PricingRules.calculateCardPaymentFee(billAmount, 0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Credit Card Bills', style: AppTextStyles.title), backgroundColor: AppColors.surface),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildQuotaBanner(),
            const SizedBox(height: 14),
            CreditCardCarouselItem(card: activeCard),
            const SizedBox(height: 16),
            _buildAmountSelector(activeCard.dueAmount, minDue),
            const SizedBox(height: 16),
            _buildFeeSummary(billAmount, fee),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Pay ${AppFormatters.formatRupee(billAmount + fee)}',
              isLoading: _paying,
              onPressed: () => _handlePayment(activeCard, billAmount, fee),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotaBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('FREE QUOTA POLICY', style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700, fontSize: 10)),
          Text('2 of 2 Free', style: AppTextStyles.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 4),
        Text('Pricing rule: 2 free card payments per calendar month (1% fee applies afterwards).', style: AppTextStyles.caption.copyWith(fontSize: 11)),
      ]),
    );
  }

  Widget _buildAmountSelector(double totalDue, double minDue) {
    return Row(children: [
      Expanded(child: _chip('Total Due (${AppFormatters.formatRupee(totalDue)})', 'total')),
      const SizedBox(width: 8),
      Expanded(child: _chip('Min Due (${AppFormatters.formatRupee(minDue)})', 'min')),
    ]);
  }

  Widget _chip(String label, String mode) {
    final sel = _mode == mode;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 11, color: sel ? Colors.white : AppColors.textPrimary)),
      selected: sel,
      selectedColor: AppColors.brand,
      onSelected: (_) => setState(() => _mode = mode),
    );
  }

  Widget _buildFeeSummary(double billAmount, double fee) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Billed Amount', style: AppTextStyles.caption),
          Text(AppFormatters.formatRupee(billAmount), style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
        ]),
        const SizedBox(height: 6),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Platform Fee (Pricing Rule)', style: AppTextStyles.caption),
          Text(fee > 0 ? AppFormatters.formatRupee(fee) : 'FREE (₹0)', style: AppTextStyles.bodyBold.copyWith(color: fee > 0 ? AppColors.warning : AppColors.success, fontSize: 13)),
        ]),
      ]),
    );
  }

  Future<void> _handlePayment(CardBill card, double amount, double fee) async {
    setState(() => _paying = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SuccessScreen(
        amount: amount + fee, recipientName: card.bank, recipientUpi: 'cardpayment@hdfc', cashback: 20, rewardPoints: 100,
      )));
    }
  }
}
