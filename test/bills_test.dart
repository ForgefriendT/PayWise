import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/core/pricing_rules.dart';
import 'package:paywise/data/models/bill.dart';
import 'package:paywise/features/bills/bill_categories_grid.dart';
import 'package:paywise/features/bills/saved_bills_list.dart';

void main() {
  testWidgets('BillCategoriesGrid renders all service items', (tester) async {
    String? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BillCategoriesGrid(onCategoryTap: (c) => selected = c),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Electricity'), findsOneWidget);
    expect(find.text('Mobile'), findsOneWidget);
    expect(find.text('FASTag Recharge'), findsOneWidget);
    expect(find.text('Credit Card'), findsOneWidget);

    await tester.tap(find.text('Electricity'));
    expect(selected, 'electricity');
  });

  testWidgets('SavedBillsList shows biller and triggers callbacks', (tester) async {
    final bill = Bill(
      id: '88492019482',
      provider: 'BESCOM Electricity',
      category: 'electricity',
      amount: 1420.0,
      dueDate: DateTime.now().add(const Duration(days: 3)),
      autopay: false,
      autopayMax: 2500.0,
      reminderDays: 2,
    );

    bool autopayClicked = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SavedBillsList(
            bills: [bill],
            onAutopayTap: (_) => autopayClicked = true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('BESCOM Electricity'), findsOneWidget);
    expect(find.textContaining('1,420'), findsOneWidget);
    expect(find.textContaining('Due in'), findsOneWidget);

    await tester.tap(find.text('Set up Autopay'));
    expect(autopayClicked, true);
  });

  test('PricingRules correctly applies credit card fees', () {
    expect(PricingRules.calculateCardPaymentFee(5000, 0), 0.0);
    expect(PricingRules.calculateCardPaymentFee(5000, 1), 0.0);
    expect(PricingRules.calculateCardPaymentFee(5000, 2), 50.0); // 1% of 5000
  });
}
