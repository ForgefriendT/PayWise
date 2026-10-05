import 'dart:math';

// Pure loan EMI and eligibility math calculations
class EmiCalculatorLogic {
  static double calculateMaxLoan(double monthlyIncome) {
    return (monthlyIncome * 10.0).clamp(10000.0, 1000000.0);
  }

  static double calculateEmi(double loanAmount, double annualRate, int months) {
    if (loanAmount <= 0 || months <= 0) return 0.0;
    final r = annualRate / 12.0;
    final power = pow(1.0 + r, months).toDouble();
    return (loanAmount * r * power) / (power - 1.0);
  }

  static double calculateTotalInterest(double emi, int months, double loanAmount) {
    final total = emi * months;
    return max(0.0, total - loanAmount);
  }

  static double calculateSafeRatio(double emi, double monthlyIncome) {
    if (monthlyIncome <= 0) return 0.0;
    return (emi / monthlyIncome) * 100.0;
  }
}
