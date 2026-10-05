import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

// Custom clean numeric keypad for quick currency entry
class PayNumpad extends StatelessWidget {
  final ValueChanged<String> onKeyPress;
  final VoidCallback onDelete;

  const PayNumpad({
    super.key,
    required this.onKeyPress,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', 'DEL'],
    ];

    return Column(
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((key) {
            return Expanded(
              child: InkWell(
                onTap: key == 'DEL' ? onDelete : () => onKeyPress(key),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: key == 'DEL'
                      ? const Icon(Icons.backspace_outlined, size: 22, color: AppColors.textPrimary)
                      : Text(
                          key,
                          style: AppTextStyles.title.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
