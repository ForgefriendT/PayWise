import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/app_icon.dart';

// Utility services 3-col grid and quick pills matching Stitch Screen 10
class BillCategoriesGrid extends StatelessWidget {
  final ValueChanged<String>? onCategoryTap;

  const BillCategoriesGrid({super.key, this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'id': 'electricity', 'icon': 'flash', 'label': 'Electricity', 'sub': 'BESCOM, TNEB+'},
      {'id': 'mobile', 'icon': 'mobile', 'label': 'Mobile', 'sub': 'Prepaid / Post'},
      {'id': 'dth', 'icon': 'dth', 'label': 'DTH Cable', 'sub': 'Tata Play, Sun'},
      {'id': 'gas', 'icon': 'gas', 'label': 'Piped Gas', 'sub': 'IGL, Adani'},
      {'id': 'water', 'icon': 'water', 'label': 'Water Board', 'sub': 'Municipal bills'},
      {'id': 'broadband', 'icon': 'wifi', 'label': 'Broadband', 'sub': 'Fiber & WiFi'},
    ];

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.2,
          ),
          itemCount: services.length,
          itemBuilder: (context, i) {
            final s = services[i];
            return _buildTile(s['id']!, s['icon']!, s['label']!, s['sub']!);
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildQuickPill(context, 'FASTag Recharge', 'Instant', 'car', null)),
            const SizedBox(width: 8),
            Expanded(child: _buildQuickPill(context, 'Credit Card', 'New', 'card', () => context.push('/credit-card-bill'))),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildQuickPill(context, 'Insurance', 'IRDAI', 'shield', () => context.push('/insurance'))),
            const SizedBox(width: 8),
            Expanded(child: _buildQuickPill(context, 'Loans & Credit', 'Pre-approved', 'loan', () => context.push('/lending'))),
          ],
        ),
      ],
    );
  }

  Widget _buildTile(String id, String icon, String label, String sub) {
    return GestureDetector(
      onTap: () => onCategoryTap?.call(id),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.brandSoft,
                shape: BoxShape.circle,
              ),
              child: Center(child: AppIcon(icon, size: 20, color: AppColors.brand)),
            ),
            const SizedBox(height: 6),
            Text(label, style: AppTextStyles.bodyBold.copyWith(fontSize: 12), maxLines: 1),
            Text(sub, style: AppTextStyles.caption.copyWith(fontSize: 10), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPill(BuildContext context, String label, String tag, String icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppIcon(icon, size: 16, color: AppColors.brand),
                const SizedBox(width: 6),
                Text(label, style: AppTextStyles.bodyBold.copyWith(fontSize: 11)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: AppColors.brandSoft, borderRadius: BorderRadius.circular(999)),
              child: Text(tag, style: AppTextStyles.caption.copyWith(color: AppColors.brand, fontWeight: FontWeight.w700, fontSize: 9)),
            ),
          ],
        ),
      ),
    );
  }
}
