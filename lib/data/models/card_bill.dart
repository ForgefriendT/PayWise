// Credit card outstanding balance model
class CardBill {
  final String id;
  final String bank;
  final String last4;
  final double dueAmount;
  final DateTime dueDate;

  const CardBill({
    required this.id,
    required this.bank,
    required this.last4,
    required this.dueAmount,
    required this.dueDate,
  });

  factory CardBill.fromMap(String id, Map<String, dynamic> map) {
    return CardBill(
      id: id,
      bank: map['bank'] ?? 'HDFC Bank',
      last4: map['last4'] ?? '0000',
      dueAmount: (map['dueAmount'] as num?)?.toDouble() ?? 0.0,
      dueDate: map['dueDate'] != null
          ? DateTime.tryParse(map['dueDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bank': bank,
      'last4': last4,
      'dueAmount': dueAmount,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}
