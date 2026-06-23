import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/controller/cart_cubit.dart';
import 'package:ecommerce_one/controller/cart_state.dart';
import 'package:ecommerce_one/controller/favorites_cubit.dart';
import 'package:ecommerce_one/controller/favorites_state.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/utils/services/button_widget.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemProduct extends StatelessWidget {
  final ProductModel product;
  final bool discount;
  final bool expandedShowCart;
  const ItemProduct({
    super.key,
    required this.product,
    required this.discount,
    this.expandedShowCart = false,
  });

  @override
  Widget build(BuildContext context) {
    final showDiscount = discount && product.hasDiscount;
    if (expandedShowCart) {
      return GestureDetector(
        onTap: () => ToWithFade(AppRoutes.productDetails, arguments: product),
        child: Card(
          elevation: 1,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            height: hi * 0.16,
            width: wi,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: hi * 0.16,
                      width: wi * 0.3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Center(child: Image.asset(product.imageAsset)),
                    ),
                    Visibility(
                      visible: showDiscount,

                      child: Container(
                        height: hi * 0.05,
                        width: wi * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: DefaultText(
                            "${product.discountPercent}%",
                            fontSize: 10.5,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: wi * 0.05),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        product.name,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: hi * 0.01),
                      SizedBox(
                        width: wi * 0.8,
                        child: DefaultText(
                          product.description,
                          overflow: TextOverflow.visible,

                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6D6D6D),
                        ),
                      ),
                      SizedBox(height: hi * 0.01),
                      DefaultText(
                        "\$${product.price.toStringAsFixed(2)}",
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                        fontSize: 9.79,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primaryColor,
                      ),
                      SizedBox(height: hi * 0.01),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, cartState) {
                          final isInCart = cartState.items.any(
                            (item) => item.product.id == product.id,
                          );
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: wi * 0.22,
                                child: ButtonWidget(
                                  title:
                                      isInCart
                                          ? context.tr('added_to_cart')
                                          : context.tr('add_to_cart'),
                                  radius: 5,
                                  fontWeight: FontWeight.w500,
                                  sizeTitle: 6,
                                  heightButton: 25,
                                  colorButton:
                                      isInCart
                                          ? ColorManager.greyColor
                                          : ColorManager.primaryColor,
                                  onTap:
                                      isInCart
                                          ? null
                                          : () => context
                                              .read<CartCubit>()
                                              .addProduct(product),
                                ),
                              ),
                              SizedBox(
                                width: wi * 0.22,
                                child: ButtonWidgetBorder(
                                  title: context.tr('buy_now'),
                                  radius: 5,
                                  colorButton: ColorManager.primaryColor,
                                  colorTitle: ColorManager.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  sizeTitle: 6,
                                  heightButton: 25,
                                  onTap: () {
                                    context
                                        .read<CartCubit>()
                                        .addProductIfNeeded(product);
                                    ToWithFade(AppRoutes.cart);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: wi * 0.03),
              ],
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => ToWithFade(AppRoutes.productDetails, arguments: product),
        child: Card(
          elevation: 1,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            height: hi * 0.31,
            width: wi * 0.5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: hi * 0.18,
                      width: wi * 0.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Center(child: Image.asset(product.imageAsset)),
                    ),
                    Positioned(
                      left: 8,
                      top: 8,
                      child: BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFavorite = state.isFavorite(product.id);
                          return GestureDetector(
                            onTap:
                                () => context
                                    .read<FavoritesCubit>()
                                    .toggleFavorite(product),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  isFavorite
                                      ? Colors.red
                                      : ColorManager.primaryColor,
                              size: 20,
                            ),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: showDiscount,

                      child: Container(
                        height: hi * 0.05,
                        width: wi * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: DefaultText(
                            "${product.discountPercent}%",
                            fontSize: 10.5,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: hi * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DefaultText(
                    product.name,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: hi * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DefaultText(
                    product.description,
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                    fontSize: 8.39,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6D6D6D),
                  ),
                ),
                SizedBox(height: hi * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DefaultText(
                    "\$${product.price.toStringAsFixed(2)}",
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                    fontSize: 9.79,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
