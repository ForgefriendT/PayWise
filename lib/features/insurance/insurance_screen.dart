import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../data/app_provider.dart';
import 'claim_tracker_card.dart';
import 'insurance_policy_data.dart';
import 'policy_card.dart';

// Insurance discovery and claim tracker screen matching Stitch Screen 15
class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  int _mainTab = 0; // 0: Active & Claims, 1: Explore Plans
  String _selectedFilter = 'all';
  int _claimStep = 2; // Step 2: Under Review

  @override
  Widget build(BuildContext context) {
    final list = InsurancePolicyData.recommended;
    final filtered = _selectedFilter == 'all' ? list : list.where((p) => p['filter'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Insurance & Claims', style: AppTextStyles.title.copyWith(fontSize: 18)),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            _buildTabSwitcher(),
            const SizedBox(height: 14),
            if (_mainTab == 0) ...[
              ClaimTrackerCard(
                step: _claimStep,
                onAdvance: () {
                  setState(() => _claimStep = _claimStep < 4 ? _claimStep + 1 : 1);
                  final app = context.read<AppProvider>();
                  final uid = app.authUser?.uid;
                  if (uid != null && app.claims.isNotEmpty) {
                    app.firestoreService.updateClaim(uid, app.claims.first.id, _claimStep);
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
            _buildFilterHeader(),
            const SizedBox(height: 10),
            ...filtered.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PolicyCard(
                title: p['title']!,
                category: p['category']!,
                tag: p['tag']!,
                icon: p['icon']!,
                iconColor: p['iconColor']!,
                premium: p['premium']!,
                feature1: p['feature1']!,
                feature2: p['feature2']!,
                trustNote: p['trustNote']!,
                onBuy: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subscribed to ${p['title']}! Active in policy locker.')));
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.divider)),
      child: Row(
        children: [
          Expanded(child: _buildTabBtn('Active & Claims (1)', _mainTab == 0, () => setState(() => _mainTab = 0))),
          Expanded(child: _buildTabBtn('Explore Plans', _mainTab == 1, () => setState(() => _mainTab = 1))),
        ],
      ),
    );
  }

  Widget _buildTabBtn(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: active ? AppColors.brand : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Text(title, style: TextStyle(fontSize: 12, fontWeight: active ? FontWeight.w700 : FontWeight.w500, color: active ? Colors.white : AppColors.textSecondary)),
      ),
    );
  }

  Widget _buildFilterHeader() {
    const filters = ['all', 'health', 'vehicle', 'life'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recommended For You', style: AppTextStyles.title.copyWith(fontSize: 16)),
            const Text('IRDAI Certified', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: filters.map((f) {
            final isSel = _selectedFilter == f;
            return GestureDetector(
              onTap: () => setState(() => _selectedFilter = f),
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: isSel ? AppColors.brand : AppColors.surface, borderRadius: BorderRadius.circular(999), border: Border.all(color: isSel ? AppColors.brand : AppColors.divider)),
                child: Text(f[0].toUpperCase() + f.substring(1), style: TextStyle(fontSize: 11, fontWeight: isSel ? FontWeight.w700 : FontWeight.w500, color: isSel ? Colors.white : AppColors.textSecondary)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
