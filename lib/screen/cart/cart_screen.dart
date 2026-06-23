// ignore_for_file: must_be_immutable

import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/controller/cart_cubit.dart';
import 'package:ecommerce_one/controller/cart_state.dart';
import 'package:ecommerce_one/screen/cart/card_total_cart.dart';
import 'package:ecommerce_one/screen/cart/item_cart.dart';
import 'package:ecommerce_one/screen/widget/app_bar_widget.dart';

import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  final bool showBackButton;

  const CartScreen({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          AppBarWidget(search: false, canBack: showBackButton),
          SizedBox(height: hi * 0.02),
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return Center(
                    child: DefaultText(
                      context.tr('cart_empty'),
                      fontSize: 14,
                      color: ColorManager.textGrey,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          elevation: 1,
                          margin: EdgeInsets.zero,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children:
                                  state.items
                                      .map((item) => ItemCart(item: item))
                                      .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: hi * 0.02),
                        CartTotalCard(),
                        SizedBox(height: hi * 0.05),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
