import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';
import '../../data/models/payment_transaction.dart';

// Bottom sheet for topping up the PayWise wallet
class AddMoneySheet extends StatefulWidget {
  const AddMoneySheet({super.key});

  @override
  State<AddMoneySheet> createState() => _AddMoneySheetState();
}

class _AddMoneySheetState extends State<AddMoneySheet> {
  double _amount = 1000.0;
  final TextEditingController _controller = TextEditingController(text: '1000');
  String _method = 'upi';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const chips = [500.0, 1000.0, 2000.0, 5000.0];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 12),
          Text('Top-Up PayWise Wallet', style: AppTextStyles.title.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('₹', style: AppTextStyles.title.copyWith(fontSize: 24, color: AppColors.brand)),
                const SizedBox(width: 4),
                IntrinsicWidth(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.title.copyWith(fontSize: 24),
                    decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                    onChanged: (v) => setState(() => _amount = double.tryParse(v) ?? 0.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: chips.map((c) {
              final isSel = _amount == c;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() { _amount = c; _controller.text = c.toInt().toString(); }),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: isSel ? AppColors.brandSoft : AppColors.background, borderRadius: BorderRadius.circular(8)),
                    child: Text('+${AppFormatters.formatRupee(c)}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isSel ? AppColors.brand : AppColors.textSecondary)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          _buildMethodOption('upi', 'UPI Auto-load', 'Instant • Zero surcharge', Icons.bolt),
          _buildMethodOption('card', 'Debit Card', 'Visa / Mastercard / RuPay', Icons.credit_card),
          _buildMethodOption('netbanking', 'Net Banking', 'All major Indian banks', Icons.account_balance),
          const SizedBox(height: 14),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, minimumSize: const Size(double.infinity, 48)),
            onPressed: _executeTopUp,
            child: Text('Add ${AppFormatters.formatRupee(_amount)} to Wallet', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodOption(String id, String title, String sub, IconData icon) {
    final isSel = _method == id;
    return GestureDetector(
      onTap: () => setState(() => _method = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: isSel ? AppColors.brandSoft : AppColors.background, borderRadius: BorderRadius.circular(10), border: Border.all(color: isSel ? AppColors.brand : AppColors.divider)),
        child: Row(children: [
          Icon(icon, size: 18, color: isSel ? AppColors.brand : AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSel ? AppColors.brand : AppColors.textPrimary)),
            Text(sub, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          ])),
          if (isSel) const Icon(Icons.check_circle, size: 16, color: AppColors.brand),
        ]),
      ),
    );
  }

  Future<void> _executeTopUp() async {
    final app = context.read<AppProvider>();
    final uid = app.authUser?.uid;
    final user = app.userProfile;
    if (uid == null || user == null || _amount <= 0) return;

    await app.firestoreService.updateUser(uid, {'walletBalance': user.walletBalance + _amount});
    final tx = PaymentTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: _amount,
      direction: 'received',
      status: 'completed',
      category: 'transfers',
      counterpartyName: 'Wallet Top-Up',
      counterpartyUpi: user.upiId,
      note: 'Wallet top-up via $_method',
      cashback: 0.0,
      fee: 0.0,
      createdAt: DateTime.now(),
    );
    await app.firestoreService.addTransaction(uid, tx);

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${AppFormatters.formatRupee(_amount)} to your wallet!')));
    }
  }
}
