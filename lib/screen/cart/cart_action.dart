import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/controller/cart_cubit.dart';
import 'package:ecommerce_one/controller/orders_cubit.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/utils/services/button_widget.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartActions extends StatelessWidget {
  const CartActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ButtonWidget(
            title: context.tr('checkout'),
            radius: 10,
            onTap: () {
              final cartCubit = context.read<CartCubit>();
              final cartState = cartCubit.state;
              final order = context.read<OrdersCubit>().createOrder(
                items: cartState.items,
                subtotal: cartState.subtotal,
                shipping: cartState.shipping,
                discount: cartState.discount,
              );
              if (order != null) {
                cartCubit.clearCart(silent: true);
                ToWithFade(AppRoutes.orders);
              }
            },
          ),
          const SizedBox(height: 10),
          ButtonWidget(
            title:
                context.watch<CartCubit>().state.items.isEmpty
                    ? context.tr('back_to_shopping')
                    : context.tr('clear_cart'),
            radius: 10,
            colorButton: ColorManager.border,
            onTap: () {
              final cartState = context.read<CartCubit>().state;
              if (cartState.items.isEmpty) {
                ToWithFade(AppRoutes.allProduct);
              } else {
                context.read<CartCubit>().clearCart();
              }
            },
          ),
        ],
      ),
    );
  }
}
