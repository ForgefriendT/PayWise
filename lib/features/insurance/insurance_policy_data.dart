import '../../core/theme/colors.dart';

// Sample recommended policy definitions matching Stitch Screen 15
class InsurancePolicyData {
  static const List<Map<String, dynamic>> recommended = [
    {
      'title': 'Health Shield Super',
      'category': 'Family Floater Plan',
      'tag': 'Fast Issue',
      'filter': 'health',
      'icon': 'heart-pulse',
      'iconColor': AppColors.danger,
      'premium': '₹540/mo',
      'feature1': '₹10 Lakhs Cover',
      'feature2': '10,000+ Cashless',
      'trustNote': 'Instant policy on app',
    },
    {
      'title': 'Comprehensive Drive',
      'category': 'Two-Wheeler & Car Coverage',
      'tag': 'Zero Dep',
      'filter': 'vehicle',
      'icon': 'car',
      'iconColor': AppColors.info,
      'premium': '₹850/yr',
      'feature1': 'Roadside Help 24/7',
      'feature2': '100% Zero Dep',
      'trustNote': 'Zero paper inspection',
    },
    {
      'title': 'Pure Term Life Protection',
      'category': 'Pure term secure safety-net',
      'tag': 'Tax Saver',
      'filter': 'life',
      'icon': 'shield',
      'iconColor': AppColors.brand,
      'premium': '₹690/mo',
      'feature1': '₹1 Crore Cover',
      'feature2': 'Sec 80C Benefit',
      'trustNote': '99.2% Settlement ratio',
    },
  ];
}
