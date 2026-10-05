import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/primary_button.dart';

// QR scanner screen with animated scan line, camera frame, and demo simulation
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _scanLineCtrl;
  final TextEditingController _upiCtrl = TextEditingController();
  final MobileScannerController _scannerCtrl = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _scanLineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanLineCtrl.dispose();
    _scannerCtrl.dispose();
    _upiCtrl.dispose();
    super.dispose();
  }

  void _onQrDetected(String raw) {
    String pa = 'priya@okhdfcbank';
    String pn = 'Priya Patel';
    double am = 0.0;

    final uri = Uri.tryParse(raw);
    if (uri != null && uri.scheme == 'upi') {
      pa = uri.queryParameters['pa'] ?? pa;
      pn = uri.queryParameters['pn'] ?? pn;
      am = double.tryParse(uri.queryParameters['am'] ?? '0') ?? 0.0;
    }
    context.push('/pay', extra: {'upiId': pa, 'name': pn, 'amount': am});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('Scan Any UPI QR', style: AppTextStyles.title.copyWith(color: Colors.white)),
        leading: IconButton(
          icon: const AppIcon('close', size: 22, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: _scannerCtrl,
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                _onQrDetected(barcodes.first.rawValue!);
              }
            },
          ),
          _buildScanFrame(),
          Positioned(bottom: 24, left: 20, right: 20, child: _buildControls()),
        ],
      ),
    );
  }

  Widget _buildScanFrame() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
      ),
      child: AnimatedBuilder(
        animation: _scanLineCtrl,
        builder: (context, child) {
          return Align(
            alignment: Alignment(0, (_scanLineCtrl.value * 2) - 1),
            child: Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.brand,
                boxShadow: [
                  BoxShadow(color: AppColors.brand, blurRadius: 10, spreadRadius: 1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
          label: 'Simulate Demo QR Scan',
          icon: const AppIcon('qr', size: 20, color: Colors.white),
          onPressed: () => _onQrDetected('upi://pay?pa=priya@okhdfcbank&pn=Priya%20Patel&am=2500'),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => context.push('/contacts'),
          child: Text(
            'Or pay from Contacts',
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
