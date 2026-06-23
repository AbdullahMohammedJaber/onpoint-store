import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const PriceRow({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          DefaultText(
            title,
            fontSize: isTotal ? 16 : 12,
            fontWeight: isTotal ? FontWeight.w500 : FontWeight.w400,
          ),
          const Spacer(),
          DefaultText(
            value,
            fontSize: isTotal ? 16 : 12,
            fontWeight: isTotal ? FontWeight.w500 : FontWeight.w400,
            color: ColorManager.primaryColor,
          ),
        ],
      ),
    );
  }
}
