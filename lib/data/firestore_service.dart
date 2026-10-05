import 'package:cloud_firestore/cloud_firestore.dart';
import 'demo_data.dart';
import 'models/bill.dart';
import 'models/card_bill.dart';
import 'models/claim.dart';
import 'models/contact.dart';
import 'models/investment.dart';
import 'models/pause_entry.dart';
import 'models/payment_transaction.dart';
import 'models/policy.dart';
import 'models/user_profile.dart';

// Single gateway for all Cloud Firestore database operations
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference _userCol(String uid, String path) =>
      _db.collection('users').doc(uid).collection(path);

  // User profile stream
  Stream<UserProfile?> streamUser(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) return null;
      return UserProfile.fromMap(uid, snap.data()!);
    });
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) =>
      _db.collection('users').doc(uid).set(data, SetOptions(merge: true));

  // Transactions stream & create
  Stream<List<PaymentTransaction>> streamTransactions(String uid) {
    return _userCol(uid, 'transactions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs
            .map((d) => PaymentTransaction.fromMap(d.id, d.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> addTransaction(String uid, PaymentTransaction tx) =>
      _userCol(uid, 'transactions').add(tx.toMap());

  // Contacts, Bills, Cards streams
  Stream<List<Contact>> streamContacts(String uid) => _userCol(uid, 'contacts')
      .snapshots()
      .map((s) => s.docs.map((d) => Contact.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());

  Stream<List<Bill>> streamBills(String uid) => _userCol(uid, 'bills')
      .snapshots()
      .map((s) => s.docs.map((d) => Bill.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());

  Future<void> updateBill(String uid, String billId, Map<String, dynamic> map) =>
      _userCol(uid, 'bills').doc(billId).update(map);

  Stream<List<CardBill>> streamCards(String uid) => _userCol(uid, 'cards')
      .snapshots()
      .map((s) => s.docs.map((d) => CardBill.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());

  // Investments, Policies, Claims streams
  Stream<List<Investment>> streamInvestments(String uid) => _userCol(uid, 'investments')
      .snapshots()
      .map((s) => s.docs.map((d) => Investment.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());

  Stream<List<Policy>> streamPolicies(String uid) => _userCol(uid, 'policies')
      .snapshots()
      .map((s) => s.docs.map((d) => Policy.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());

  Stream<List<Claim>> streamClaims(String uid) => _userCol(uid, 'claims')
      .snapshots()
      .map((s) => s.docs.map((d) => Claim.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());

  Future<void> addClaim(String uid, Claim claim) =>
      _userCol(uid, 'claims').add(claim.toMap());

  Future<void> updateClaim(String uid, String claimId, int step) =>
      _userCol(uid, 'claims').doc(claimId).update({
        'step': step,
        'updatedAt': DateTime.now().toIso8601String(),
      });

  // PayPause entries stream & create
  Stream<List<PauseEntry>> streamPauses(String uid) => _userCol(uid, 'pauses')
      .snapshots()
      .map((s) => s.docs.map((d) => PauseEntry.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());

  Future<void> addPause(String uid, PauseEntry pause) =>
      _userCol(uid, 'pauses').add(pause.toMap());

  // Seeds initial mock data for first-time login
  Future<void> seedDemoData(String uid) async {
    final batch = _db.batch();
    batch.set(_db.collection('users').doc(uid), DemoData.initialUser());

    for (final c in DemoData.contacts) {
      batch.set(_userCol(uid, 'contacts').doc(), c);
    }
    for (final b in DemoData.bills) {
      batch.set(_userCol(uid, 'bills').doc(), b);
    }
    for (final card in DemoData.cards) {
      batch.set(_userCol(uid, 'cards').doc(), card);
    }
    for (final inv in DemoData.investments) {
      batch.set(_userCol(uid, 'investments').doc(), inv);
    }
    for (final pol in DemoData.policies) {
      batch.set(_userCol(uid, 'policies').doc(), pol);
    }
    for (final cl in DemoData.claims) {
      batch.set(_userCol(uid, 'claims').doc(), cl);
    }
    for (final p in DemoData.pauses) {
      batch.set(_userCol(uid, 'pauses').doc(), p);
    }
    for (final tx in DemoData.generateTransactions()) {
      batch.set(_userCol(uid, 'transactions').doc(), tx);
    }
    await batch.commit();
  }
}
