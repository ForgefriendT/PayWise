import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Modal displaying user UPI QR code for receiving money matching Stitch Screen 18
class QrPreviewDialog extends StatelessWidget {
  final String name;
  final String upiId;

  const QrPreviewDialog({super.key, required this.name, required this.upiId});

  static void show(BuildContext context, String name, String upiId) {
    showDialog(
      context: context,
      builder: (_) => QrPreviewDialog(name: name, upiId: upiId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Receive Money', style: AppTextStyles.title.copyWith(fontSize: 16)),
                IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.qr_code_2, size: 160, color: AppColors.brand),
            ),
            const SizedBox(height: 14),
            Text(name, style: AppTextStyles.bodyBold.copyWith(fontSize: 16)),
            Text(upiId, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand, minimumSize: const Size(double.infinity, 44)),
              onPressed: () => Navigator.pop(context),
              child: const Text('Done', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
