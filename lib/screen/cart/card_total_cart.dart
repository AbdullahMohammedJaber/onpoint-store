import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/controller/cart_cubit.dart';
import 'package:ecommerce_one/controller/cart_state.dart';
import 'package:ecommerce_one/screen/cart/cart_action.dart';
import 'package:ecommerce_one/screen/cart/copon_field.dart';
import 'package:ecommerce_one/screen/cart/payment_methode.dart';
import 'package:ecommerce_one/screen/cart/price_row.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartTotalCard extends StatelessWidget {
  const CartTotalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: hi * 0.01),
              _title(context),
              Divider(thickness: 0.5, color: ColorManager.border),
              const CouponField(),
              Divider(thickness: 0.5, color: ColorManager.border),

              _prices(context, state),
              Divider(thickness: 0.5, color: ColorManager.border),

              const PaymentMethods(),
              const CartActions(),
            ],
          ),
        );
      },
    );
  }

  Widget _title(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    child: DefaultText(
      context.tr('cart_total'),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );

  Widget _prices(BuildContext context, CartState state) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        PriceRow(
          title: context.tr('subtotal'),
          value: "\$${state.subtotal.toStringAsFixed(2)}",
        ),
        PriceRow(
          title: context.tr('coupon_discount'),
          value: "-\$${state.discount.toStringAsFixed(2)}",
        ),
        PriceRow(
          title: context.tr('shipping'),
          value: "\$${state.shipping.toStringAsFixed(2)}",
        ),
        Divider(thickness: 0.5, color: ColorManager.border),
        PriceRow(
          title: context.tr('total_usd'),
          value: "\$${state.total.toStringAsFixed(2)}",
          isTotal: true,
        ),
      ],
    ),
  );
}
