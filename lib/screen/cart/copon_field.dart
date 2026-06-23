import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';

class CouponField extends StatelessWidget {
  const CouponField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            context.tr('coupon_discount'),
            fontSize: 12,
            color: ColorManager.textGrey,
          ),
          const SizedBox(height: 10),
          Row(children: [Expanded(child: _field(context)), _button(context)]),
        ],
      ),
    );
  }

  Widget _field(BuildContext context) => TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
      hintText: context.tr('coupon_hint'),
      hintStyle: const TextStyle(fontSize: 10),
      border: _border(context , left: true),
      enabledBorder: _border(context ,left: true),
    ),
  );

  Widget _button(BuildContext context) => Container(
    width: wi * 0.25,
    height: 48,
    decoration: BoxDecoration(
      color: ColorManager.primaryColor,
      borderRadius:context.locale.languageCode == 'ar'? BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ) :  BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    child: Center(
      child: DefaultText(
        context.tr('apply'),
        color: ColorManager.whiteColor,
        fontSize: 12,
      ),
    ),
  );

  OutlineInputBorder _border(BuildContext context ,{bool left = false}) {
    return OutlineInputBorder(
      borderRadius:context.locale.languageCode == 'ar'?BorderRadius.only(
        topRight: Radius.circular(left ? 8 : 0),
        bottomRight: Radius.circular(left ? 8 : 0),
      ): BorderRadius.only(
        topLeft: Radius.circular(left ? 8 : 0),
        bottomLeft: Radius.circular(left ? 8 : 0),
      ),
      borderSide: BorderSide(color: ColorManager.primaryColor),
    );
  }
}
