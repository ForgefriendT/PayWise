// Saved UPI contact beneficiary model
class Contact {
  final String id;
  final String name;
  final String upiId;
  final String bank;

  const Contact({
    required this.id,
    required this.name,
    required this.upiId,
    required this.bank,
  });

  factory Contact.fromMap(String id, Map<String, dynamic> map) {
    return Contact(
      id: id,
      name: map['name'] ?? '',
      upiId: map['upiId'] ?? '',
      bank: map['bank'] ?? 'State Bank of India',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'upiId': upiId,
      'bank': bank,
    };
  }
}
