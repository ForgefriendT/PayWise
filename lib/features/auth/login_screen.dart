import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/app_provider.dart';
import 'login_footer.dart';
import 'login_header.dart';

// Login screen matching Stitch Screen 01 design with email and demo anonymous auth
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController(text: 'alex.morgan@paywise.me');
  final _passCtrl = TextEditingController(text: 'password123');
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  Future<void> _handleDemoLogin() async {
    setState(() { _loading = true; _error = null; });
    try {
      await context.read<AppProvider>().authService.signInAnonymously();
    } catch (e) {
      if (mounted) setState(() => _error = 'Demo sign-in failed. Please check network.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleEmailLogin() async {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (email.isEmpty || pass.isEmpty) return;

    final auth = context.read<AppProvider>().authService;
    setState(() { _loading = true; _error = null; });
    try {
      await auth.signInWithEmail(email, pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential' || e.code == 'INVALID_LOGIN_CREDENTIALS') {
        try {
          await auth.registerWithEmail(email, pass);
          return;
        } catch (_) {}
      }
      if (mounted) setState(() => _error = e.message ?? 'Sign-in failed. Try "Continue as demo user".');
    } catch (_) {
      if (mounted) setState(() => _error = 'Sign-in failed. Try "Continue as demo user".');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(children: [const LoginHeader(), _buildFormCard(), const SizedBox(height: 24), const LoginFooter()]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_error != null) Padding(padding: const EdgeInsets.only(bottom: 12), child: Text(_error!, style: AppTextStyles.caption.copyWith(color: AppColors.danger))),
          Text('Email address', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: _emailCtrl,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              hintText: 'name@example.com',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              suffixIcon: const Padding(padding: EdgeInsets.all(12), child: AppIcon('bill', size: 18, color: AppColors.textSecondary)),
            ),
          ),
          const SizedBox(height: 14),
          Text('Password', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: _passCtrl,
            obscureText: _obscure,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              hintText: 'Enter secure password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              suffixIcon: IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, size: 20, color: AppColors.textSecondary),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(label: 'Sign In', isLoading: _loading, onPressed: _handleEmailLogin),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: Divider(color: AppColors.divider)),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('OR', style: AppTextStyles.caption)),
              const Expanded(child: Divider(color: AppColors.divider)),
            ],
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Continue as demo user',
            isLoading: _loading,
            backgroundColor: AppColors.brandSoft,
            textColor: AppColors.brand,
            icon: const AppIcon('flash', size: 18, color: AppColors.brand),
            onPressed: _handleDemoLogin,
          ),
        ],
      ),
    );
  }
}
