// Investment holdings model for mutual funds and fixed deposits
class Investment {
  final String id;
  final String type; // 'mf' or 'fd'
  final String name;
  final double invested;
  final double currentValue;

  const Investment({
    required this.id,
    required this.type,
    required this.name,
    required this.invested,
    required this.currentValue,
  });

  factory Investment.fromMap(String id, Map<String, dynamic> map) {
    return Investment(
      id: id,
      type: map['type'] ?? 'mf',
      name: map['name'] ?? '',
      invested: (map['invested'] as num?)?.toDouble() ?? 0.0,
      currentValue: (map['currentValue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'invested': invested,
      'currentValue': currentValue,
    };
  }
}
