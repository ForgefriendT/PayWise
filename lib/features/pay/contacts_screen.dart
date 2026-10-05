import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/formatters.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/bottom_sheet_shell.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/app_provider.dart';
import '../../data/models/contact.dart';

// Searchable UPI contacts list with beneficiary detail sheet
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showBeneficiarySheet(Contact c) {
    final txs = context.read<AppProvider>().transactions.where((t) => t.counterpartyUpi == c.upiId).take(3).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => BottomSheetShell(
        title: 'Beneficiary Details',
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(c.name, style: AppTextStyles.title),
              Text(c.upiId, style: AppTextStyles.caption.copyWith(color: AppColors.brand)),
              Text('Linked: ${c.bank}', style: AppTextStyles.caption),
              const SizedBox(height: 16),
              Text('Recent payments to ${c.name}', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              if (txs.isEmpty)
                const Text('No recent transactions with this contact.', style: TextStyle(fontSize: 12, color: Colors.grey))
              else
                ...txs.map((t) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppFormatters.formatDate(t.createdAt), style: AppTextStyles.caption),
                      Text(AppFormatters.formatRupee(t.amount), style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                )),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Pay ${c.name}',
                onPressed: () {
                  Navigator.pop(context);
                  context.push('/pay', extra: {'upiId': c.upiId, 'name': c.name});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contacts = context.watch<AppProvider>().contacts.where((c) {
      return c.name.toLowerCase().contains(_query.toLowerCase()) ||
          c.upiId.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Select Contact', style: AppTextStyles.title),
        backgroundColor: AppColors.surface,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: contacts.isEmpty
                ? const EmptyState(title: 'No contacts found', message: 'Try searching another name or UPI ID', icon: 'contact')
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: contacts.length,
                    separatorBuilder: (_, _) => const Divider(height: 1, indent: 68, color: AppColors.divider),
                    itemBuilder: (context, i) {
                      final c = contacts[i];
                      return ListTile(
                        leading: Hero(
                          tag: 'avatar-${c.upiId}',
                          child: CircleAvatar(
                            backgroundColor: AppColors.brandSoft,
                            child: Text(c.name.substring(0, 1), style: AppTextStyles.heading.copyWith(color: AppColors.brand)),
                          ),
                        ),
                        title: Text(c.name, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                        subtitle: Text('${c.upiId} • ${c.bank}', style: AppTextStyles.caption),
                        trailing: const AppIcon('chevron-right', size: 18, color: AppColors.textSecondary),
                        onTap: () => _showBeneficiarySheet(c),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (v) => setState(() => _query = v),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.background,
          hintText: 'Search name, mobile or UPI ID',
          prefixIcon: const Padding(padding: EdgeInsets.all(12), child: AppIcon('search', size: 18, color: AppColors.textSecondary)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
