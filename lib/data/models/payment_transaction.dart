// Transaction record model for payments and transfers
class PaymentTransaction {
  final String id;
  final double amount;
  final String direction; // 'sent' or 'received'
  final String status; // 'completed', 'processing', 'failed'
  final String category;
  final String counterpartyName;
  final String counterpartyUpi;
  final String note;
  final double cashback;
  final double fee;
  final DateTime createdAt;

  const PaymentTransaction({
    required this.id,
    required this.amount,
    required this.direction,
    required this.status,
    required this.category,
    required this.counterpartyName,
    required this.counterpartyUpi,
    required this.note,
    required this.cashback,
    required this.fee,
    required this.createdAt,
  });

  factory PaymentTransaction.fromMap(String id, Map<String, dynamic> map) {
    return PaymentTransaction(
      id: id,
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      direction: map['direction'] ?? 'sent',
      status: map['status'] ?? 'completed',
      category: map['category'] ?? 'transfers',
      counterpartyName: map['counterpartyName'] ?? '',
      counterpartyUpi: map['counterpartyUpi'] ?? '',
      note: map['note'] ?? '',
      cashback: (map['cashback'] as num?)?.toDouble() ?? 0.0,
      fee: (map['fee'] as num?)?.toDouble() ?? 0.0,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'direction': direction,
      'status': status,
      'category': category,
      'counterpartyName': counterpartyName,
      'counterpartyUpi': counterpartyUpi,
      'note': note,
      'cashback': cashback,
      'fee': fee,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
