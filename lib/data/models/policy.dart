// Insurance policy recommendation and active policy model
class Policy {
  final String id;
  final String name;
  final String type; // 'Health', 'Term', 'Motor', 'Travel'
  final String insurer;
  final double premium;
  final double cover;
  final String status; // 'recommended' or 'active'

  const Policy({
    required this.id,
    required this.name,
    required this.type,
    required this.insurer,
    required this.premium,
    required this.cover,
    required this.status,
  });

  factory Policy.fromMap(String id, Map<String, dynamic> map) {
    return Policy(
      id: id,
      name: map['name'] ?? '',
      type: map['type'] ?? 'Health',
      insurer: map['insurer'] ?? '',
      premium: (map['premium'] as num?)?.toDouble() ?? 0.0,
      cover: (map['cover'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] ?? 'recommended',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'insurer': insurer,
      'premium': premium,
      'cover': cover,
      'status': status,
    };
  }
}
