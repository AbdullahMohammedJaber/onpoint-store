import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            context.tr('payment_method'),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 10),
          Row(children: [SvgPicture.asset("assets/icons/visa.svg")]),
        ],
      ),
    );
  }
}
