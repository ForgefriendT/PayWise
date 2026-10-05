import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/app_provider.dart';
import '../../data/models/pause_entry.dart';
import '../../data/models/payment_transaction.dart';
import '../paypause/paypause_logic.dart';
import '../paypause/paypause_sheet.dart';
import 'pay_amount_display.dart';
import 'pay_category_selector.dart';
import 'pay_numpad.dart';
import 'success_screen.dart';

// Payment entry screen with big keypad, category chips, PayPause check, and simulation
class PayScreen extends StatefulWidget {
  final String upiId;
  final String name;
  final double initialAmount;

  const PayScreen({super.key, required this.upiId, required this.name, this.initialAmount = 0});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String _amountStr = '';
  String _category = 'food';
  bool _processing = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialAmount > 0) _amountStr = widget.initialAmount.toInt().toString();
  }

  void _onKeyPress(String key) {
    if (key == '.' && _amountStr.contains('.')) return;
    if (_amountStr.length < 7) setState(() => _amountStr += key);
  }

  void _onDelete() {
    if (_amountStr.isNotEmpty) setState(() => _amountStr = _amountStr.substring(0, _amountStr.length - 1));
  }

  Future<void> _handleProceed() async {
    final amount = double.tryParse(_amountStr) ?? 0.0;
    if (amount <= 0) return;
    final p = context.read<AppProvider>();
    final user = p.userProfile;
    if (user == null) return;

    final spent = p.transactions
        .where((t) => t.category == _category && t.direction == 'sent' && t.createdAt.month == DateTime.now().month)
        .fold(0.0, (sum, t) => sum + t.amount);

    final eval = PayPauseLogic.evaluate(
      categoryId: _category,
      amount: amount,
      spentSoFar: spent,
      budgets: user.monthlyBudgets,
      paypauseEnabled: user.paypauseOn,
    );

    if (eval.shouldTrigger) {
      final ok = await PayPauseSheet.show(
        context,
        eval: eval,
        onSkip: () async {
          await p.firestoreService.addPause(user.uid, PauseEntry(id: '', amount: amount, category: _category, createdAt: DateTime.now()));
          if (mounted) context.go('/');
        },
        onProceed: () => _executePayment(amount, user.uid, user.simulateFailure),
      );
      if (ok != true) return;
    } else {
      _executePayment(amount, user.uid, user.simulateFailure);
    }
  }

  Future<void> _executePayment(double amount, String uid, bool simFail) async {
    final p = context.read<AppProvider>();
    setState(() => _processing = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    final cash = (amount * 0.01).clamp(0.0, 20.0).roundToDouble();
    final pts = (amount / 10).floor();

    await p.firestoreService.addTransaction(uid, PaymentTransaction(
      id: '', amount: amount, direction: 'sent', status: simFail ? 'failed' : 'completed',
      category: _category, counterpartyName: widget.name, counterpartyUpi: widget.upiId,
      note: 'Payment', cashback: simFail ? 0.0 : cash, fee: 0.0, createdAt: DateTime.now(),
    ));

    if (!simFail) {
      final u = p.userProfile!;
      await p.firestoreService.updateUser(uid, {
        'walletBalance': (u.walletBalance - amount + cash).clamp(0.0, double.infinity),
        'cashbackTotal': u.cashbackTotal + cash, 'rewardPoints': u.rewardPoints + pts,
      });
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SuccessScreen(
          amount: amount, recipientName: widget.name, recipientUpi: widget.upiId, cashback: cash, rewardPoints: pts,
        )));
      }
    } else if (mounted) {
      setState(() => _processing = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment failed (Simulate failure active)')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final balance = context.watch<AppProvider>().userProfile?.walletBalance ?? 0.0;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Paying ${widget.name}', style: AppTextStyles.title), backgroundColor: AppColors.surface),
      body: SafeArea(
        child: Column(
          children: [
            PayAmountDisplay(upiId: widget.upiId, amountStr: _amountStr, walletBalance: balance),
            PayCategorySelector(selectedCategory: _category, onSelected: (c) => setState(() => _category = c)),
            const Spacer(),
            PayNumpad(onKeyPress: _onKeyPress, onDelete: _onDelete),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(label: 'Proceed to Pay', isLoading: _processing, onPressed: _amountStr.isNotEmpty ? _handleProceed : null),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
