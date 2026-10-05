// Initial demo seed data generator for new PayWise accounts
class DemoData {
  static Map<String, dynamic> initialUser() => {
        'name': 'Fauzan Baig',
        'upiId': 'fauzan@paywise',
        'walletBalance': 14500.0,
        'rewardPoints': 1250,
        'cashbackTotal': 240.0,
        'goldGrams': 2.5,
        'paypauseOn': true,
        'simulateFailure': false,
        'monthlyBudgets': {
          'shopping': 8000.0,
          'food': 4000.0,
          'entertainment': 3000.0,
          'travel': 5000.0,
        },
        'profile': {'age': 22, 'dependents': 0, 'hasVehicle': true},
      };

  static List<Map<String, dynamic>> contacts = [
    {'name': 'Rahul Sharma', 'upiId': 'rahul@oksbi', 'bank': 'State Bank of India'},
    {'name': 'Priya Patel', 'upiId': 'priya@okhdfcbank', 'bank': 'HDFC Bank'},
    {'name': 'Aarav Mehta', 'upiId': 'aarav@icici', 'bank': 'ICICI Bank'},
    {'name': 'Ananya Roy', 'upiId': 'ananya@axl', 'bank': 'Axis Bank'},
    {'name': 'Vikram Singh', 'upiId': 'vikram@paytm', 'bank': 'Paytm Payments Bank'},
    {'name': 'Sneha Rao', 'upiId': 'sneha@ybl', 'bank': 'Yes Bank'},
    {'name': 'Karan Verma', 'upiId': 'karan@barodampay', 'bank': 'Bank of Baroda'},
    {'name': 'Pooja Nair', 'upiId': 'pooja@kotak', 'bank': 'Kotak Mahindra Bank'},
  ];

  static List<Map<String, dynamic>> bills = [
    {'provider': 'BESCOM Electricity', 'category': 'electricity', 'amount': 1420.0, 'dueDate': DateTime.now().add(const Duration(days: 3)).toIso8601String(), 'autopay': false, 'autopayMax': 2000.0, 'reminderDays': 3},
    {'provider': 'Airtel Broadband', 'category': 'wifi', 'amount': 999.0, 'dueDate': DateTime.now().add(const Duration(days: 8)).toIso8601String(), 'autopay': true, 'autopayMax': 1500.0, 'reminderDays': 2},
    {'provider': 'Jio Prepaid Mobile', 'category': 'mobile', 'amount': 349.0, 'dueDate': DateTime.now().add(const Duration(days: 12)).toIso8601String(), 'autopay': false, 'autopayMax': 500.0, 'reminderDays': 1},
    {'provider': 'Tata Play DTH', 'category': 'dth', 'amount': 450.0, 'dueDate': DateTime.now().add(const Duration(days: 15)).toIso8601String(), 'autopay': false, 'autopayMax': 600.0, 'reminderDays': 3},
    {'provider': 'Indane Gas Cylinder', 'category': 'gas', 'amount': 860.0, 'dueDate': DateTime.now().add(const Duration(days: 20)).toIso8601String(), 'autopay': false, 'autopayMax': 1000.0, 'reminderDays': 2},
  ];

  static List<Map<String, dynamic>> cards = [
    {'bank': 'HDFC Regalia', 'last4': '4019', 'dueAmount': 14200.0, 'dueDate': DateTime.now().add(const Duration(days: 4)).toIso8601String()},
    {'bank': 'ICICI Coral', 'last4': '8821', 'dueAmount': 6850.0, 'dueDate': DateTime.now().add(const Duration(days: 18)).toIso8601String()},
  ];

  static List<Map<String, dynamic>> investments = [
    {'type': 'mf', 'name': 'Nifty 50 Index Fund', 'invested': 45000.0, 'currentValue': 53200.0},
    {'type': 'mf', 'name': 'Parag Parikh Flexi Cap', 'invested': 35000.0, 'currentValue': 41800.0},
    {'type': 'fd', 'name': 'HDFC 1-Year Fixed Deposit', 'invested': 30000.0, 'currentValue': 32340.0},
  ];

  static List<Map<String, dynamic>> policies = [
    {'name': 'Health Shield 360', 'type': 'Health', 'insurer': 'Care Insurance', 'premium': 540.0, 'cover': 1000000.0, 'status': 'recommended'},
    {'name': 'Comprehensive Motor Protection', 'type': 'Motor', 'insurer': 'Bajaj Allianz', 'premium': 320.0, 'cover': 150000.0, 'status': 'recommended'},
    {'name': 'Smart Term Life Cover', 'type': 'Term', 'insurer': 'Max Life', 'premium': 680.0, 'cover': 10000000.0, 'status': 'recommended'},
    {'name': 'Family Health Optima', 'type': 'Health', 'insurer': 'Star Health', 'premium': 780.0, 'cover': 500000.0, 'status': 'active'},
  ];

  static List<Map<String, dynamic>> claims = [
    {'policyId': 'Family Health Optima', 'step': 1, 'updatedAt': DateTime.now().subtract(const Duration(days: 2)).toIso8601String()},
  ];

  static List<Map<String, dynamic>> pauses = [
    {'amount': 2400.0, 'category': 'shopping', 'createdAt': DateTime.now().subtract(const Duration(days: 12)).toIso8601String()},
    {'amount': 1800.0, 'category': 'food', 'createdAt': DateTime.now().subtract(const Duration(days: 5)).toIso8601String()},
  ];

  // Procedurally generates ~40 realistic transactions across 60 days
  static List<Map<String, dynamic>> generateTransactions() {
    final list = <Map<String, dynamic>>[];
    final now = DateTime.now();
    final categories = ['food', 'shopping', 'grocery', 'bills', 'entertainment', 'travel', 'transfers'];
    final counterparties = ['Swiggy', 'Zomato', 'Amazon', 'Blinkit', 'Uber', 'Rahul Sharma', 'Priya Patel', 'Aarav Mehta'];

    for (int i = 0; i < 40; i++) {
      final daysAgo = (i * 1.5).round();
      final cat = categories[i % categories.length];
      final isIncome = i % 7 == 0;
      final amount = isIncome ? (2000.0 + (i * 250)) : (150.0 + (i * 75) % 2400);

      list.add({
        'amount': amount,
        'direction': isIncome ? 'received' : 'sent',
        'status': i == 11 ? 'failed' : 'completed',
        'category': cat,
        'counterpartyName': counterparties[i % counterparties.length],
        'counterpartyUpi': '${counterparties[i % counterparties.length].toLowerCase().replaceAll(" ", "")}@upi',
        'note': isIncome ? 'Payment received' : 'Payment for $cat',
        'cashback': isIncome ? 0.0 : (amount >= 200 ? 15.0 : 0.0),
        'fee': 0.0,
        'createdAt': now.subtract(Duration(days: daysAgo, hours: i % 12, minutes: (i * 7) % 60)).toIso8601String(),
      });
    }
    return list;
  }
}
