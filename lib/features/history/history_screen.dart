import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/empty_state.dart';
import '../../data/app_provider.dart';
import '../../data/models/payment_transaction.dart';
import 'grouped_transaction_list.dart';
import 'history_filter_chips.dart';
import 'month_selector_bar.dart';
import 'outflow_summary_card.dart';
import 'spending_pie_chart.dart';
import 'transaction_detail_sheet.dart';

// History & Spending Analysis screen matching Stitch Screen 08
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _currentMonth = DateTime(2026, 10);
  String _activeFilter = 'all';
  String _searchQuery = '';
  bool _searchOpen = false;

  @override
  Widget build(BuildContext context) {
    final allTxs = context.watch<AppProvider>().transactions;
    final filtered = _filterTransactions(allTxs);
    final outflow = allTxs
        .where((t) => t.direction == 'sent' && t.createdAt.month == _currentMonth.month)
        .fold(0.0, (s, t) => s + t.amount);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(const Duration(milliseconds: 500)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_searchOpen) _buildSearchBar(),
              MonthSelectorBar(currentMonth: _currentMonth, onMonthChanged: (m) => setState(() => _currentMonth = m)),
              OutflowSummaryCard(totalOutflow: outflow > 0 ? outflow : 32450.0),
              SpendingPieChart(transactions: allTxs),
              const SizedBox(height: 8),
              HistoryFilterChips(
                activeFilter: _activeFilter,
                totalCount: allTxs.length,
                onFilterSelected: (f) => setState(() => _activeFilter = f),
              ),
              const SizedBox(height: 12),
              filtered.isEmpty
                  ? const EmptyState(title: 'No transactions found', message: 'No payments matched this filter.', icon: 'history')
                  : GroupedTransactionList(
                      transactions: filtered,
                      onTransactionTap: (tx) => TransactionDetailSheet.show(context, tx),
                    ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PAYWISE', style: AppTextStyles.caption.copyWith(fontSize: 10, letterSpacing: 1.2)),
          Text('History & Spending Analysis', style: AppTextStyles.heading.copyWith(fontSize: 16)),
        ],
      ),
      actions: [
        IconButton(
          icon: const AppIcon('search', size: 20, color: AppColors.textSecondary),
          onPressed: () => setState(() => _searchOpen = !_searchOpen),
        ),
        IconButton(
          icon: const AppIcon('bell', size: 20, color: AppColors.textSecondary),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search by name or category...',
          filled: true,
          fillColor: AppColors.surface,
          prefixIcon: const Padding(padding: EdgeInsets.all(12), child: AppIcon('search', size: 16, color: AppColors.textSecondary)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.divider)),
        ),
        onChanged: (q) => setState(() => _searchQuery = q.toLowerCase()),
      ),
    );
  }

  List<PaymentTransaction> _filterTransactions(List<PaymentTransaction> list) {
    return list.where((t) {
      if (_searchQuery.isNotEmpty) {
        final matches = t.counterpartyName.toLowerCase().contains(_searchQuery) || t.category.toLowerCase().contains(_searchQuery);
        if (!matches) return false;
      }
      if (_activeFilter == 'sent') return t.direction == 'sent';
      if (_activeFilter == 'received') return t.direction == 'received';
      if (_activeFilter == 'bills') return t.category == 'bills';
      if (_activeFilter == 'failed') return t.status == 'failed';
      return true;
    }).toList();
  }
}
