import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/core/pricing_rules.dart';

void main() {
  group('PricingRules', () {
    test('Credit card bill payment has 2 free payments then 1% fee', () {
      // First two payments in a month are free
      expect(PricingRules.calculateCardPaymentFee(5000, 0), 0.0);
      expect(PricingRules.calculateCardPaymentFee(10000, 1), 0.0);

      // Third payment incurs 1% fee
      expect(PricingRules.calculateCardPaymentFee(10000, 2), 100.0);
      expect(PricingRules.calculateCardPaymentFee(2500, 3), 25.0);
    });

    test('Bank transfer validates daily limit of Rs 1,00,000', () {
      // Allowed within limit
      final okResult = PricingRules.validateBankTransfer(40000, 30000);
      expect(okResult.allowed, isTrue);

      // Blocked when exceeding limit
      final blockedResult = PricingRules.validateBankTransfer(80000, 30000);
      expect(blockedResult.allowed, isFalse);
      expect(blockedResult.message, contains('₹70000 left today'));

      // Blocked on zero/negative
      final invalidResult = PricingRules.validateBankTransfer(0, 0);
      expect(invalidResult.allowed, isFalse);
    });
  });
}
