// User profile and account preferences model
class UserProfile {
  final String uid;
  final String name;
  final String upiId;
  final double walletBalance;
  final int rewardPoints;
  final double cashbackTotal;
  final double goldGrams;
  final bool paypauseOn;
  final bool simulateFailure;
  final Map<String, double> monthlyBudgets;
  final Map<String, dynamic> profile;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.upiId,
    required this.walletBalance,
    required this.rewardPoints,
    required this.cashbackTotal,
    required this.goldGrams,
    required this.paypauseOn,
    this.simulateFailure = false,
    required this.monthlyBudgets,
    required this.profile,
  });

  factory UserProfile.fromMap(String uid, Map<String, dynamic> map) {
    final rawBudgets = map['monthlyBudgets'] as Map<String, dynamic>? ?? {};
    final budgets = rawBudgets.map(
      (k, v) => MapEntry(k, (v as num).toDouble()),
    );

    return UserProfile(
      uid: uid,
      name: map['name'] ?? 'User',
      upiId: map['upiId'] ?? 'user@paywise',
      walletBalance: (map['walletBalance'] as num?)?.toDouble() ?? 0.0,
      rewardPoints: (map['rewardPoints'] as num?)?.toInt() ?? 0,
      cashbackTotal: (map['cashbackTotal'] as num?)?.toDouble() ?? 0.0,
      goldGrams: (map['goldGrams'] as num?)?.toDouble() ?? 0.0,
      paypauseOn: map['paypauseOn'] ?? true,
      simulateFailure: map['simulateFailure'] ?? false,
      monthlyBudgets: budgets,
      profile: (map['profile'] as Map<String, dynamic>?) ?? {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'upiId': upiId,
      'walletBalance': walletBalance,
      'rewardPoints': rewardPoints,
      'cashbackTotal': cashbackTotal,
      'goldGrams': goldGrams,
      'paypauseOn': paypauseOn,
      'simulateFailure': simulateFailure,
      'monthlyBudgets': monthlyBudgets,
      'profile': profile,
    };
  }
}
