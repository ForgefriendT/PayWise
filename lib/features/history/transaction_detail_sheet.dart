import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models/payment_transaction.dart';
import 'transaction_audit_trail.dart';
import 'transaction_meta_card.dart';
import 'transaction_receipt_hero.dart';

// Modal bottom sheet displaying detailed transaction receipt matching Stitch Screen 09
class TransactionDetailSheet extends StatelessWidget {
  final PaymentTransaction tx;

  const TransactionDetailSheet({super.key, required this.tx});

  static Future<void> show(BuildContext context, PaymentTransaction tx) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TransactionDetailSheet(tx: tx),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(99))),
            const SizedBox(height: 12),
            _buildTopBar(context),
            TransactionReceiptHero(tx: tx),
            const SizedBox(height: 16),
            TransactionAuditTrail(timestamp: tx.createdAt, status: tx.status, counterpartyName: tx.counterpartyName),
            const SizedBox(height: 14),
            TransactionMetaCard(tx: tx),
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(icon: const AppIcon('close', size: 18, color: AppColors.textPrimary), onPressed: () => Navigator.of(context).pop()),
            Text('Receipt', style: AppTextStyles.heading.copyWith(fontSize: 16)),
          ],
        ),
        Row(
          children: [
            IconButton(icon: const AppIcon('card', size: 18, color: AppColors.textSecondary), onPressed: () => _copySummary(context)),
            IconButton(icon: const AppIcon('share', size: 18, color: AppColors.textSecondary), onPressed: () => _copySummary(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brand,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const AppIcon('send', size: 18, color: Colors.white),
            label: const Text('Repeat Payment', style: TextStyle(fontWeight: FontWeight.w600)),
            onPressed: () {
              Navigator.of(context).pop();
              context.push('/pay', extra: {'name': tx.counterpartyName, 'upiId': tx.counterpartyUpi, 'amount': tx.amount});
            },
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => _showHelpDialog(context),
          child: Text('Need help with this payment? Raise a ticket', style: AppTextStyles.caption.copyWith(color: AppColors.brand)),
        ),
      ],
    );
  }

  void _copySummary(BuildContext context) {
    final text = 'Paid ${AppFormatters.formatRupee(tx.amount)} to ${tx.counterpartyName} (${tx.counterpartyUpi}) via PayWise. Ref: UPI/${tx.id}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Receipt summary copied to clipboard')));
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Report Issue', style: AppTextStyles.title.copyWith(fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: const Text('Money debited but not received'), onTap: () => _ticketRaised(context)),
            ListTile(title: const Text('Wrong amount charged'), onTap: () => _ticketRaised(context)),
            ListTile(title: const Text('Suspected unauthorized transaction'), onTap: () => _ticketRaised(context)),
          ],
        ),
      ),
    );
  }

  void _ticketRaised(BuildContext context) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Support ticket #PW-8491 created. We will reach out within 2 hours.')));
  }
}
