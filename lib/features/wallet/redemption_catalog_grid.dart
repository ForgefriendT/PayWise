import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';

// Redemption catalog grid with point deduction and disabled state matching Stitch Screen 17
class RedemptionCatalogGrid extends StatefulWidget {
  final int userPoints;
  const RedemptionCatalogGrid({super.key, required this.userPoints});

  @override
  State<RedemptionCatalogGrid> createState() => _RedemptionCatalogGridState();
}

class _RedemptionCatalogGridState extends State<RedemptionCatalogGrid> {
  String _filter = 'all';

  final List<Map<String, dynamic>> _items = const [
    {'title': '₹100 Amazon Pay', 'sub': 'Voucher Code', 'cost': 500, 'category': 'shopping', 'icon': Icons.shopping_bag, 'color': AppColors.brand, 'type': 'voucher'},
    {'title': '₹50 Swiggy Money', 'sub': 'Food & Groceries', 'cost': 250, 'category': 'dining', 'icon': Icons.restaurant, 'color': Colors.deepOrange, 'type': 'voucher'},
    {'title': '0.05 gm 24K Gold', 'sub': 'Direct to Locker', 'cost': 370, 'category': 'gold', 'icon': Icons.monetization_on, 'color': Colors.amber, 'type': 'gold'},
    {'title': '₹50 Cash Back', 'sub': 'To PayWise Wallet', 'cost': 250, 'category': 'all', 'icon': Icons.savings, 'color': AppColors.success, 'type': 'cash'},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'all' ? _items : _items.where((i) => i['category'] == _filter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Redeem Your Points', style: AppTextStyles.title.copyWith(fontSize: 16)),
            const Text('Instant delivery', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 8),
        _buildFilterBar(),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.95,
          ),
          itemCount: filtered.length,
          itemBuilder: (context, i) => _buildCard(filtered[i]),
        ),
      ],
    );
  }

  Widget _buildFilterBar() {
    const filters = ['all', 'shopping', 'dining', 'gold'];
    return Row(
      children: filters.map((f) {
        final isSel = _filter == f;
        return GestureDetector(
          onTap: () => setState(() => _filter = f),
          child: Container(
            margin: const EdgeInsets.only(right: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: isSel ? AppColors.brand : AppColors.surface, borderRadius: BorderRadius.circular(999), border: Border.all(color: isSel ? AppColors.brand : AppColors.divider)),
            child: Text(f[0].toUpperCase() + f.substring(1), style: TextStyle(fontSize: 10, fontWeight: isSel ? FontWeight.w700 : FontWeight.w500, color: isSel ? Colors.white : AppColors.textSecondary)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCard(Map<String, dynamic> item) {
    final cost = item['cost'] as int;
    final canAfford = widget.userPoints >= cost;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: (item['color'] as Color).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(item['icon'] as IconData, size: 18, color: item['color'] as Color),
              ),
              Text('$cost Pts', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, color: canAfford ? AppColors.brand : AppColors.textSecondary)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['title'] as String, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, fontSize: 12), maxLines: 1),
              Text(item['sub'] as String, style: AppTextStyles.caption.copyWith(fontSize: 10)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: canAfford ? AppColors.brand : AppColors.divider,
              foregroundColor: canAfford ? Colors.white : AppColors.textSecondary,
              minimumSize: const Size(double.infinity, 32),
              padding: EdgeInsets.zero,
              elevation: 0,
            ),
            onPressed: canAfford ? () => _claimItem(item, cost) : null,
            child: Text(canAfford ? 'Claim Now' : 'Need ${cost - widget.userPoints} pts', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Future<void> _claimItem(Map<String, dynamic> item, int cost) async {
    final app = context.read<AppProvider>();
    final uid = app.authUser?.uid;
    final user = app.userProfile;
    if (uid == null || user == null) return;

    final updates = <String, dynamic>{'rewardPoints': user.rewardPoints - cost};
    if (item['type'] == 'cash') {
      updates['walletBalance'] = user.walletBalance + 50.0;
    } else if (item['type'] == 'gold') {
      updates['goldGrams'] = user.goldGrams + 0.05;
    }
    await app.firestoreService.updateUser(uid, updates);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully redeemed ${item['title']}!')));
    }
  }
}
