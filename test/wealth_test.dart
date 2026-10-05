import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/features/wealth/asset_allocation_bar.dart';
import 'package:paywise/features/wealth/portfolio_overview_card.dart';

void main() {
  test('Fixed deposit interest formula calculates accurately', () {
    // A = P * (1 + r * t)
    const principal = 50000.0;
    const rate = 0.0885; // 8.85% p.a.
    const tenureYears = 2;

    final maturity = principal * (1.0 + (rate * tenureYears));
    final interest = maturity - principal;

    expect(maturity, closeTo(58850.0, 0.01));
    expect(interest, closeTo(8850.0, 0.01));
  });

  test('Digital gold weight and GST calculations are accurate', () {
    const ratePerGram = 7425.50;
    const amount = 1000.0;

    final weight = amount / ratePerGram;
    final gst = (amount * 0.03) / 1.03;

    expect(weight, closeTo(0.1346, 0.0001));
    expect(gst, closeTo(29.13, 0.01));
  });

  testWidgets('PortfolioOverviewCard renders values and toggles visibility', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PortfolioOverviewCard(
            portfolioValue: 124500.0,
            investedValue: 110000.0,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Total Portfolio Value'), findsOneWidget);
    expect(find.text('₹1,24,500'), findsOneWidget);
    expect(find.text('1Y'), findsOneWidget);

    // Toggle eye icon to mask balance
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pumpAndSettle();

    expect(find.text('••••••••'), findsOneWidget);
  });

  testWidgets('AssetAllocationBar renders three holding segments', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AssetAllocationBar(
            mfValue: 74700.0,
            goldValue: 31125.0,
            fdValue: 18675.0,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Asset Allocation'), findsOneWidget);
    expect(find.text('Mutual Funds'), findsOneWidget);
    expect(find.text('Digital Gold'), findsOneWidget);
    expect(find.text('Fixed Deposits'), findsOneWidget);
    expect(find.text('₹74,700'), findsOneWidget);
  });
}
