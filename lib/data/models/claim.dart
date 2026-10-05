// Insurance claim progress model
class Claim {
  final String id;
  final String policyId;
  final int step; // 0: Submitted, 1: Under review, 2: Approved, 3: Paid
  final DateTime updatedAt;

  const Claim({
    required this.id,
    required this.policyId,
    required this.step,
    required this.updatedAt,
  });

  factory Claim.fromMap(String id, Map<String, dynamic> map) {
    return Claim(
      id: id,
      policyId: map['policyId'] ?? '',
      step: (map['step'] as num?)?.toInt() ?? 0,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'policyId': policyId,
      'step': step,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
