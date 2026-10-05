import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/features/paypause/paypause_logic.dart';

void main() {
  group('PayPauseLogic', () {
    const budgets = {'food': 4000.0, 'shopping': 8000.0, 'bills': 5000.0};

    test('Triggers when payment exceeds Rs 2,000 or projected exceeds 80%', () {
      // Case 1: Amount >= 2000 on Food
      final eval1 = PayPauseLogic.evaluate(
        categoryId: 'food',
        amount: 2500,
        spentSoFar: 500,
        budgets: budgets,
        paypauseEnabled: true,
      );
      expect(eval1.shouldTrigger, isTrue);
      expect(eval1.impactSentence, contains('Food Delivery'));
      expect(eval1.impactSentence, contains('75%'));

      // Case 2: Projected > 80% (spent 3000 + 500 = 3500 / 4000 = 87.5%)
      final eval2 = PayPauseLogic.evaluate(
        categoryId: 'food',
        amount: 500,
        spentSoFar: 3000,
        budgets: budgets,
        paypauseEnabled: true,
      );
      expect(eval2.shouldTrigger, isTrue);
      expect(eval2.projectedPercent, greaterThan(80.0));
    });

    test('Does NOT trigger for essential categories or within safe budget', () {
      // Essential category (bills) never triggers PayPause
      final evalEssential = PayPauseLogic.evaluate(
        categoryId: 'bills',
        amount: 3500,
        spentSoFar: 1000,
        budgets: budgets,
        paypauseEnabled: true,
      );
      expect(evalEssential.shouldTrigger, isFalse);

      // Small amount within safe limit on Food (spent 400 + 300 = 700 / 4000 = 17.5%)
      final evalSafe = PayPauseLogic.evaluate(
        categoryId: 'food',
        amount: 300,
        spentSoFar: 400,
        budgets: budgets,
        paypauseEnabled: true,
      );
      expect(evalSafe.shouldTrigger, isFalse);

      // When PayPause switch is disabled
      final evalDisabled = PayPauseLogic.evaluate(
        categoryId: 'food',
        amount: 3000,
        spentSoFar: 2000,
        budgets: budgets,
        paypauseEnabled: false,
      );
      expect(evalDisabled.shouldTrigger, isFalse);
    });
  });
}
