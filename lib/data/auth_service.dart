import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart';

// Authentication service handling email and anonymous demo logins
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestore = FirestoreService();

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // Logs in anonymously for demo access and seeds initial data if new
  Future<UserCredential> signInAnonymously() async {
    final cred = await _auth.signInAnonymously();
    await _ensureUserSeeded(cred.user?.uid);
    return cred;
  }

  // Signs in with existing email and password
  Future<UserCredential> signInWithEmail(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _ensureUserSeeded(cred.user?.uid);
    return cred;
  }

  // Creates new account with email and password
  Future<UserCredential> registerWithEmail(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _ensureUserSeeded(cred.user?.uid);
    return cred;
  }

  // Seeds demo collections on first account creation
  Future<void> _ensureUserSeeded(String? uid) async {
    if (uid == null) return;
    final user = await _firestore.streamUser(uid).first;
    if (user == null) {
      await _firestore.seedDemoData(uid);
    }
  }

  Future<void> signOut() => _auth.signOut();
}
