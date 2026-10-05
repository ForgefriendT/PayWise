import 'package:flutter/material.dart';

// Represents a spending category with display metadata
class SpendingCategory {
  final String id;
  final String name;
  final String icon;
  final Color color;
  final bool isEssential;

  const SpendingCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.isEssential,
  });
}

// Global registry of all 8 spending categories
class AppCategories {
  static const List<SpendingCategory> all = [
    SpendingCategory(
      id: 'shopping',
      name: 'Shopping',
      icon: 'gift',
      color: Color(0xFFE83D84),
      isEssential: false,
    ),
    SpendingCategory(
      id: 'food',
      name: 'Food Delivery',
      icon: 'heart-pulse',
      color: Color(0xFFFF6B00),
      isEssential: false,
    ),
    SpendingCategory(
      id: 'entertainment',
      name: 'Entertainment',
      icon: 'trophy',
      color: Color(0xFF7B2CBF),
      isEssential: false,
    ),
    SpendingCategory(
      id: 'travel',
      name: 'Travel',
      icon: 'car',
      color: Color(0xFF0096C7),
      isEssential: false,
    ),
    SpendingCategory(
      id: 'bills',
      name: 'Bills & Utilities',
      icon: 'electricity',
      color: Color(0xFFF77F00),
      isEssential: true,
    ),
    SpendingCategory(
      id: 'grocery',
      name: 'Grocery',
      icon: 'bill',
      color: Color(0xFF2A9D8F),
      isEssential: true,
    ),
    SpendingCategory(
      id: 'health',
      name: 'Health',
      icon: 'shield',
      color: Color(0xFFE63946),
      isEssential: true,
    ),
    SpendingCategory(
      id: 'transfers',
      name: 'Transfers',
      icon: 'send',
      color: Color(0xFF457B9D),
      isEssential: true,
    ),
  ];

  static SpendingCategory findById(String id) {
    return all.firstWhere(
      (c) => c.id == id,
      orElse: () => all.last,
    );
  }
}
