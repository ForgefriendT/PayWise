// Utility bill model for dues and autopay
class Bill {
  final String id;
  final String provider;
  final String category;
  final double amount;
  final DateTime dueDate;
  final bool autopay;
  final double autopayMax;
  final int reminderDays;

  const Bill({
    required this.id,
    required this.provider,
    required this.category,
    required this.amount,
    required this.dueDate,
    required this.autopay,
    required this.autopayMax,
    required this.reminderDays,
  });

  factory Bill.fromMap(String id, Map<String, dynamic> map) {
    return Bill(
      id: id,
      provider: map['provider'] ?? '',
      category: map['category'] ?? 'electricity',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      dueDate: map['dueDate'] != null
          ? DateTime.tryParse(map['dueDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      autopay: map['autopay'] ?? false,
      autopayMax: (map['autopayMax'] as num?)?.toDouble() ?? 0.0,
      reminderDays: (map['reminderDays'] as num?)?.toInt() ?? 3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'provider': provider,
      'category': category,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'autopay': autopay,
      'autopayMax': autopayMax,
      'reminderDays': reminderDays,
    };
  }
}
