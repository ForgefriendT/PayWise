// PayPause skipped spending entry model
class PauseEntry {
  final String id;
  final double amount;
  final String category;
  final DateTime createdAt;

  const PauseEntry({
    required this.id,
    required this.amount,
    required this.category,
    required this.createdAt,
  });

  factory PauseEntry.fromMap(String id, Map<String, dynamic> map) {
    return PauseEntry(
      id: id,
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      category: map['category'] ?? 'shopping',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
