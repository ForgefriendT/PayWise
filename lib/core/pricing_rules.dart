// Centralized pricing and transaction fee rules
class PricingRules {
  // Daily bank transfer limit in rupees
  static const double maxDailyBankTransfer = 100000.0;

  // Number of free credit card bill payments per calendar month
  static const int freeCardPaymentsPerMonth = 2;

  // Convenience fee percentage applied after free tier is exhausted
  static const double cardPaymentFeeRate = 0.01;

  // Making charges percentage on digital gold
  static const double goldMakingChargeRate = 0.0;

  // Computes the fee for a credit card bill payment
  static double calculateCardPaymentFee(double amount, int paymentsThisMonth) {
    if (paymentsThisMonth < freeCardPaymentsPerMonth) {
      return 0.0;
    }
    return (amount * cardPaymentFeeRate).roundToDouble();
  }

  // Validates if a bank transfer can proceed within the daily limit
  static BankTransferResult validateBankTransfer(
    double amount,
    double transferredToday,
  ) {
    if (amount <= 0) {
      return const BankTransferResult(
        allowed: false,
        message: 'Enter a valid transfer amount',
      );
    }
    final remaining = maxDailyBankTransfer - transferredToday;
    if (amount > remaining) {
      return BankTransferResult(
        allowed: false,
        message: 'Daily transfer limit reached. ₹${remaining.toInt()} left today',
      );
    }
    return const BankTransferResult(allowed: true, message: 'Transfer allowed');
  }
}

// Holds the result of a bank transfer validation check
class BankTransferResult {
  final bool allowed;
  final String message;

  const BankTransferResult({required this.allowed, required this.message});
}
