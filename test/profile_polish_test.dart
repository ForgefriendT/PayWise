import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/features/profile/linked_accounts_card.dart';
import 'package:paywise/features/profile/profile_hero_card.dart';
import 'package:paywise/features/profile/qr_preview_dialog.dart';
import 'package:paywise/features/profile/smart_controls_card.dart';

void main() {
  testWidgets('ProfileHeroCard renders name, upi ID and KYC badge', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileHeroCard(name: 'Fauzan Baig', upiId: 'fauzan@paywise'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Fauzan Baig'), findsOneWidget);
    expect(find.text('fauzan@paywise'), findsOneWidget);
    expect(find.text('Full KYC Verified'), findsOneWidget);
    expect(find.text('My QR'), findsOneWidget);
  });

  testWidgets('SmartControlsCard renders PayPause switch and envelope budgets', (tester) async {
    bool paypause = true;
    bool simFailure = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmartControlsCard(
            paypauseOn: paypause,
            simulateFailure: simFailure,
            onPaypauseToggle: (v) => paypause = v,
            onSimulateFailureToggle: (v) => simFailure = v,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('PayPause™ Guard'), findsOneWidget);
    expect(find.text('Simulate Payment Failure'), findsOneWidget);
    expect(find.text('Food: ₹4,000'), findsOneWidget);
    expect(find.text('Shopping: ₹8,000'), findsOneWidget);
  });

  testWidgets('LinkedAccountsCard renders primary and secondary banks', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LinkedAccountsCard(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('HDFC Bank'), findsOneWidget);
    expect(find.text('DEFAULT'), findsOneWidget);
    expect(find.text('State Bank of India'), findsOneWidget);
    expect(find.text('Set Primary'), findsOneWidget);
  });

  testWidgets('QrPreviewDialog displays QR code and Done button', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: QrPreviewDialog(name: 'Fauzan Baig', upiId: 'fauzan@paywise'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Receive Money'), findsOneWidget);
    expect(find.text('Fauzan Baig'), findsOneWidget);
    expect(find.text('fauzan@paywise'), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);
  });
}
