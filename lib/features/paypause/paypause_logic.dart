import 'package:flutter/material.dart';
import '../../core/categories.dart';
import '../../core/theme/colors.dart';

// Evaluation results containing calculations and display text for PayPause
class PayPauseEvaluation {
  final bool shouldTrigger;
  final String categoryId;
  final String categoryName;
  final double amount;
  final double budget;
  final double spentSoFar;
  final double currentPercent;
  final double projectedPercent;
  final String impactSentence;
  final Color alertColor;

  const PayPauseEvaluation({
    required this.shouldTrigger,
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.budget,
    required this.spentSoFar,
    required this.currentPercent,
    required this.projectedPercent,
    required this.impactSentence,
    required this.alertColor,
  });
}

// Pure business logic evaluating if a payment requires a 5-second rethink buffer
class PayPauseLogic {
  static const Set<String> nonEssentialCategories = {
    'shopping',
    'food',
    'entertainment',
    'travel',
  };

  // Evaluates budget impact and determines if PayPause must activate
  static PayPauseEvaluation evaluate({
    required String categoryId,
    required double amount,
    required double spentSoFar,
    required Map<String, double> budgets,
    required bool paypauseEnabled,
  }) {
    final cat = AppCategories.findById(categoryId);
    final isNonEssential = nonEssentialCategories.contains(categoryId.toLowerCase());

    if (!paypauseEnabled || !isNonEssential || amount <= 0) {
      return _noTrigger(categoryId, cat.name, amount);
    }

    final budget = budgets[categoryId] ?? 4000.0;
    final projected = spentSoFar + amount;
    final currentPct = (budget > 0 ? (spentSoFar / budget) * 100 : 0.0);
    final projectedPct = (budget > 0 ? (projected / budget) * 100 : 0.0);

    final triggersByAmount = amount >= 2000.0;
    final triggersByBudget = projectedPct > 80.0;

    if (!triggersByAmount && !triggersByBudget) {
      return _noTrigger(categoryId, cat.name, amount, budget, spentSoFar);
    }

    final color = projectedPct > 100.0 ? AppColors.danger : AppColors.warning;
    final pctString = projectedPct.toStringAsFixed(0);
    final sentence =
        'This takes ${cat.name} to $pctString% of your ₹${budget.toInt()} monthly budget.';

    return PayPauseEvaluation(
      shouldTrigger: true,
      categoryId: categoryId,
      categoryName: cat.name,
      amount: amount,
      budget: budget,
      spentSoFar: spentSoFar,
      currentPercent: currentPct,
      projectedPercent: projectedPct,
      impactSentence: sentence,
      alertColor: color,
    );
  }

  static PayPauseEvaluation _noTrigger(
    String id,
    String name,
    double amount, [
    double budget = 4000.0,
    double spent = 0.0,
  ]) {
    return PayPauseEvaluation(
      shouldTrigger: false,
      categoryId: id,
      categoryName: name,
      amount: amount,
      budget: budget,
      spentSoFar: spent,
      currentPercent: 0,
      projectedPercent: 0,
      impactSentence: '',
      alertColor: AppColors.success,
    );
  }
}
