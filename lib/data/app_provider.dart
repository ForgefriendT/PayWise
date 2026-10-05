import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'firestore_service.dart';
import 'models/bill.dart';
import 'models/card_bill.dart';
import 'models/claim.dart';
import 'models/contact.dart';
import 'models/investment.dart';
import 'models/pause_entry.dart';
import 'models/payment_transaction.dart';
import 'models/policy.dart';
import 'models/user_profile.dart';

// Central application state provider providing live Firestore streams to screens
class AppProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _authUser;
  UserProfile? _userProfile;
  List<PaymentTransaction> _transactions = [];
  List<Contact> _contacts = [];
  List<Bill> _bills = [];
  List<CardBill> _cards = [];
  List<Investment> _investments = [];
  List<Policy> _policies = [];
  List<Claim> _claims = [];
  List<PauseEntry> _pauses = [];

  final List<StreamSubscription> _subscriptions = [];

  User? get authUser => _authUser;
  UserProfile? get userProfile => _userProfile;
  List<PaymentTransaction> get transactions => _transactions;
  List<Contact> get contacts => _contacts;
  List<Bill> get bills => _bills;
  List<CardBill> get cards => _cards;
  List<Investment> get investments => _investments;
  List<Policy> get policies => _policies;
  List<Claim> get claims => _claims;
  List<PauseEntry> get pauses => _pauses;
  AuthService get authService => _authService;
  FirestoreService get firestoreService => _firestoreService;

  AppProvider() {
    _authService.authStateChanges.listen(_handleAuthChange);
  }

  void _handleAuthChange(User? user) {
    _authUser = user;
    _cancelSubscriptions();

    if (user != null) {
      _subscriptions.add(_firestoreService.streamUser(user.uid).listen((p) {
        _userProfile = p;
        notifyListeners();
      }));
      _subscriptions.add(_firestoreService.streamTransactions(user.uid).listen((t) {
        _transactions = t;
        notifyListeners();
      }));
      _subscriptions.add(_firestoreService.streamContacts(user.uid).listen((c) {
        _contacts = c;
        notifyListeners();
      }));
      _subscriptions.add(_firestoreService.streamBills(user.uid).listen((b) {
        _bills = b;
        notifyListeners();
      }));
      _subscriptions.add(_firestoreService.streamCards(user.uid).listen((cd) {
        _cards = cd;
        notifyListeners();
      }));
      _subscriptions.add(_firestoreService.streamInvestments(user.uid).listen((i) {
        _investments = i;
        notifyListeners();
      }));
      _subscriptions.add(_firestoreService.streamPolicies(user.uid).listen((pol) {
        _policies = pol;
        notifyListeners();
      }));
      _subscriptions.add(_firestoreService.streamClaims(user.uid).listen((cl) {
        _claims = cl;
        notifyListeners();
      }));
      _subscriptions.add(_firestoreService.streamPauses(user.uid).listen((pa) {
        _pauses = pa;
        notifyListeners();
      }));
    } else {
      _userProfile = null;
      _transactions = [];
      _contacts = [];
      _bills = [];
      _cards = [];
      _investments = [];
      _policies = [];
      _claims = [];
      _pauses = [];
    }
    notifyListeners();
  }

  void _cancelSubscriptions() {
    for (final s in _subscriptions) {
      s.cancel();
    }
    _subscriptions.clear();
  }

  // Reloads simulated demo records in Firestore
  Future<void> reloadDemoData() async {
    if (_authUser == null) return;
    await _firestoreService.seedDemoData(_authUser!.uid);
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    super.dispose();
  }
}
