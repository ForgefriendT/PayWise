import 'package:flutter/material.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/models/bill.dart';
import 'autopay_schedule_selector.dart';

// Autopay configuration bottom sheet matching Stitch Screen 11
class AutopaySheet extends StatefulWidget {
  final Bill bill;
  final Function(double maxLimit, int reminderDays) onConfirm;

  const AutopaySheet({super.key, required this.bill, required this.onConfirm});

  static Future<void> show(BuildContext context, Bill bill, Function(double, int) onConfirm) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AutopaySheet(bill: bill, onConfirm: onConfirm),
    );
  }

  @override
  State<AutopaySheet> createState() => _AutopaySheetState();
}

class _AutopaySheetState extends State<AutopaySheet> {
  double _limit = 2500;
  int _scheduleDays = 2;

  @override
  void initState() {
    super.initState();
    if (widget.bill.autopayMax > 0) _limit = widget.bill.autopayMax;
    if (widget.bill.reminderDays > 0) _scheduleDays = widget.bill.reminderDays;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).viewInsets.bottom + 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(99)))),
            const SizedBox(height: 14),
            _buildHeader(),
            const SizedBox(height: 14),
            _buildLimitSection(),
            const SizedBox(height: 14),
            AutopayScheduleSelector(selectedDays: _scheduleDays, onSelect: (d) => setState(() => _scheduleDays = d)),
            const SizedBox(height: 14),
            _buildBankAndNotice(),
            const SizedBox(height: 16),
            PrimaryButton(label: 'Confirm Autopay (UPI Mandate)', onPressed: () {
              Navigator.of(context).pop();
              widget.onConfirm(_limit, _scheduleDays);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Set up Autopay', style: AppTextStyles.title),
          Text('${widget.bill.provider} · Upcoming: ${AppFormatters.formatRupee(widget.bill.amount)}', style: AppTextStyles.caption),
        ]),
        IconButton(icon: const AppIcon('close', size: 18, color: AppColors.textPrimary), onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }

  Widget _buildLimitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Maximum payment limit', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(AppFormatters.formatRupee(_limit), style: AppTextStyles.display.copyWith(fontSize: 22)),
            const Text('Safe Cap', style: TextStyle(color: AppColors.brand, fontWeight: FontWeight.w700, fontSize: 11)),
          ]),
        ),
        const SizedBox(height: 6),
        Row(
          children: [1500.0, 2500.0, 3500.0, 5000.0].map((val) => Padding(
            padding: const EdgeInsets.only(right: 6),
            child: ChoiceChip(
              label: Text(AppFormatters.formatRupee(val), style: TextStyle(fontSize: 10, color: _limit == val ? Colors.white : AppColors.textPrimary)),
              selected: _limit == val,
              selectedColor: AppColors.brand,
              onSelected: (_) => setState(() => _limit = val),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildBankAndNotice() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              const AppIcon('bank', size: 18, color: AppColors.brand),
              const SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('HDFC Bank ••9024', style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
                Text('Available: ₹14,500', style: AppTextStyles.caption.copyWith(color: AppColors.success)),
              ]),
            ]),
            Text('Linked', style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700)),
          ]),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            const AppIcon('shield', size: 18, color: AppColors.brand),
            const SizedBox(width: 8),
            Expanded(child: Text('We notify you 24h prior. Cancel mandate anytime in 1 tap.', style: AppTextStyles.caption.copyWith(fontSize: 11))),
          ]),
        ),
      ],
    );
  }
}
