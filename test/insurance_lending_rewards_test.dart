import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/features/insurance/claim_milestone_tracker.dart';
import 'package:paywise/features/lending/emi_calculator_logic.dart';
import 'package:paywise/features/wallet/redemption_catalog_grid.dart';
import 'package:paywise/features/wallet/rewards_hero_card.dart';

void main() {
  test('EMI calculator calculates accurate monthly payment and safe ratio', () {
    const loanAmount = 200000.0;
    const rate = 0.105;
    const months = 24;
    const monthlyIncome = 65000.0;

    final emi = EmiCalculatorLogic.calculateEmi(loanAmount, rate, months);
    final ratio = EmiCalculatorLogic.calculateSafeRatio(emi, monthlyIncome);

    expect(emi, closeTo(9280.0, 10.0));
    expect(ratio, closeTo(14.2, 0.5));
  });

  testWidgets('ClaimMilestoneTracker renders 4 steps with correct status', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ClaimMilestoneTracker(currentStep: 2),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Submitted'), findsOneWidget);
    expect(find.text('Review'), findsOneWidget);
    expect(find.text('Approved'), findsOneWidget);
    expect(find.text('Disbursed'), findsOneWidget);
  });

  testWidgets('RewardsHeroCard renders points and cash equivalent', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RewardsHeroCard(points: 1450),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1450'), findsOneWidget);
    expect(find.text('Gold Member • Level 3'), findsOneWidget);
    expect(find.textContaining('₹145'), findsOneWidget);
  });

  testWidgets('RedemptionCatalogGrid disables unaffordable items', (tester) async {
    // With 300 points: Amazon (500 pts) and Gold (370 pts) are disabled, Swiggy (250 pts) is enabled
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: RedemptionCatalogGrid(userPoints: 300),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Claim Now'), findsNWidgets(2)); // Swiggy & Cashback (250 pts each)
    expect(find.text('Need 200 pts'), findsOneWidget); // Amazon (500 - 300)
    expect(find.text('Need 70 pts'), findsOneWidget); // Gold (370 - 300)
  });
}
