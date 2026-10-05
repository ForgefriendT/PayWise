import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/data/models/payment_transaction.dart';
import 'package:paywise/features/history/history_filter_chips.dart';
import 'package:paywise/features/history/month_selector_bar.dart';
import 'package:paywise/features/history/outflow_summary_card.dart';
import 'package:paywise/features/history/spending_pie_chart.dart';

void main() {
  final demoTxs = [
    PaymentTransaction(
      id: 'tx-1',
      amount: 450.0,
      direction: 'sent',
      status: 'completed',
      category: 'food',
      counterpartyName: 'Swiggy',
      counterpartyUpi: 'swiggy@upi',
      note: 'Dinner',
      cashback: 4.5,
      fee: 0.0,
      createdAt: DateTime(2026, 10, 26, 14, 15),
    ),
    PaymentTransaction(
      id: 'tx-2',
      amount: 12500.0,
      direction: 'received',
      status: 'completed',
      category: 'transfers',
      counterpartyName: 'Acme Corp',
      counterpartyUpi: 'acme@upi',
      note: 'Stipend',
      cashback: 0.0,
      fee: 0.0,
      createdAt: DateTime(2026, 10, 26, 10, 30),
    ),
  ];

  testWidgets('SpendingPieChart renders donut and categories', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpendingPieChart(transactions: demoTxs),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Spending Breakdown'), findsOneWidget);
    expect(find.text('2 Txns'), findsOneWidget);
  });

  testWidgets('OutflowSummaryCard renders total and trend badge', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OutflowSummaryCard(totalOutflow: 32450.0),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('TOTAL OUTFLOW THIS MONTH'), findsOneWidget);
    expect(find.textContaining('32,450'), findsOneWidget);
  });

  testWidgets('HistoryFilterChips selects filter and MonthSelectorBar navigates', (tester) async {
    String selected = 'all';
    DateTime selectedMonth = DateTime(2026, 10);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              HistoryFilterChips(
                activeFilter: selected,
                totalCount: 48,
                onFilterSelected: (f) => selected = f,
              ),
              MonthSelectorBar(
                currentMonth: selectedMonth,
                onMonthChanged: (m) => selectedMonth = m,
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('All (48)'), findsOneWidget);
    expect(find.text('October 2026'), findsOneWidget);

    await tester.tap(find.text('Sent'));
    expect(selected, 'sent');
  });
}
