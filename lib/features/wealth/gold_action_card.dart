import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';
import 'gold_amount_input.dart';

// Interactive Buy/Sell action card with weight sync matching Stitch Screen 14
class GoldActionCard extends StatefulWidget {
  final double liveRate;
  const GoldActionCard({super.key, required this.liveRate});

  @override
  State<GoldActionCard> createState() => _GoldActionCardState();
}

class _GoldActionCardState extends State<GoldActionCard> {
  bool _isBuy = true;
  double _amount = 1000.0;
  final TextEditingController _controller = TextEditingController(text: '1000');

  void _onAmountChanged(double val) {
    setState(() {
      _amount = val;
      _controller.text = val.toInt().toString();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weight = widget.liveRate > 0 ? _amount / widget.liveRate : 0.0;
    final gst = (_amount * 0.03) / 1.03;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        children: [
          _buildTabs(),
          const SizedBox(height: 14),
          GoldAmountInput(
            isBuy: _isBuy,
            amount: _amount,
            liveRate: widget.liveRate,
            controller: _controller,
            onAmountChanged: _onAmountChanged,
          ),
          const SizedBox(height: 14),
          _buildSummary(gst),
          const SizedBox(height: 14),
          _buildActionButton(weight),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(child: _buildTab('Buy Gold', _isBuy, () => setState(() => _isBuy = true))),
          Expanded(child: _buildTab('Sell to Wallet', !_isBuy, () => setState(() => _isBuy = false))),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: active ? AppColors.surface : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Text(title, style: TextStyle(fontSize: 12, fontWeight: active ? FontWeight.w700 : FontWeight.w500, color: active ? AppColors.brand : AppColors.textSecondary)),
      ),
    );
  }

  Widget _buildSummary(double gst) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Live Rate Validity', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)), child: const Text('04:48s lock', style: TextStyle(color: AppColors.warning, fontSize: 10, fontWeight: FontWeight.w700))),
        ]),
        const SizedBox(height: 6),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('GST & Mandate Charges (3%)', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          Text(AppFormatters.formatRupee(gst), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ]),
        const Divider(height: 12, color: AppColors.divider),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Net Total Payable', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700)),
          Text(AppFormatters.formatRupee(_amount), style: AppTextStyles.title.copyWith(fontSize: 16, color: AppColors.brand)),
        ]),
      ]),
    );
  }

  Widget _buildActionButton(double weight) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, minimumSize: const Size(double.infinity, 48)),
      onPressed: () => _executeAction(weight),
      child: Text(
        _isBuy ? 'Proceed to Buy Gold (${AppFormatters.formatRupee(_amount)})' : 'Proceed to Sell Gold (${weight.toStringAsFixed(4)} gm)',
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
      ),
    );
  }

  Future<void> _executeAction(double weight) async {
    final provider = context.read<AppProvider>();
    final user = provider.userProfile;
    final uid = provider.authUser?.uid;
    if (user == null || uid == null) return;

    if (_isBuy) {
      if (user.walletBalance < _amount) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Insufficient wallet balance (${AppFormatters.formatRupee(user.walletBalance)})')));
        return;
      }
      await provider.firestoreService.updateUser(uid, {'walletBalance': user.walletBalance - _amount, 'goldGrams': user.goldGrams + weight});
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bought ${weight.toStringAsFixed(4)} gm gold successfully!')));
    } else {
      if (user.goldGrams < weight) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Insufficient gold holdings (${user.goldGrams.toStringAsFixed(4)} gm)')));
        return;
      }
      await provider.firestoreService.updateUser(uid, {'walletBalance': user.walletBalance + _amount, 'goldGrams': user.goldGrams - weight});
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sold ${weight.toStringAsFixed(4)} gm gold for ${AppFormatters.formatRupee(_amount)}!')));
    }
  }
}
