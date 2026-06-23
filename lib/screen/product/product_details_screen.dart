import 'package:ecommerce_one/controller/cart_cubit.dart';
import 'package:ecommerce_one/controller/cart_state.dart';
import 'package:ecommerce_one/controller/favorites_cubit.dart';
import 'package:ecommerce_one/controller/favorites_state.dart';
import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/utils/services/button_widget.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _ProductDetailsAppBar(product: product),
      bottomNavigationBar: _BottomActions(product: product),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductImage(product: product),
            SizedBox(height: hi * 0.022),
            _ProductInfo(product: product),
            SizedBox(height: hi * 0.018),
            _DescriptionCard(product: product),
          ],
        ),
      ),
    );
  }
}

class _ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final ProductModel product;

  const _ProductDetailsAppBar({required this.product});

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: preferredSize.height,
      elevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leadingWidth: 64,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: _CircleIconButton(
          icon: Icons.arrow_back,
          onTap: () => Navigator.maybePop(context),
        ),
      ),
      centerTitle: true,
      title: DefaultText(
        context.tr('product_details'),
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: theme.textTheme.bodyMedium?.color,
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 16),
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              final isFavorite = state.isFavorite(product.id);
              return _CircleIconButton(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                iconColor: isFavorite ? Colors.red : ColorManager.primaryColor,
                onTap:
                    () =>
                        context.read<FavoritesCubit>().toggleFavorite(product),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor ?? theme.iconTheme.color, size: 22),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final ProductModel product;

  const _ProductImage({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: hi * 0.38,
          decoration: BoxDecoration(
             
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: .35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .06),
                blurRadius: 22,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.all(28),
              child: Hero(
                tag: 'product-${product.id}',
                child: Image.asset(product.imageAsset, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
        if (product.hasDiscount)
          PositionedDirectional(
            top: 16,
            end: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: ColorManager.primaryDarkColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: DefaultText(
                '-${product.discountPercent}%',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final ProductModel product;

  const _ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor.withValues(alpha: .28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            product.name,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: theme.textTheme.bodyMedium?.color,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Color(0xffF6B21A), size: 16),
                    const SizedBox(width: 4),
                    DefaultText(
                      product.rating.toStringAsFixed(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (product.hasDiscount)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: Text(
                    '\$${product.oldPrice!.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: ColorManager.textGrey,
                      fontSize: 13,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              DefaultText(
                '\$${product.price.toStringAsFixed(2)}',
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: ColorManager.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final ProductModel product;

  const _DescriptionCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor.withValues(alpha: .28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            context.tr('product_details'),
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: theme.textTheme.bodyMedium?.color,
          ),
          const SizedBox(height: 10),
          DefaultText(
            product.description,
            fontSize: 14,
            height: 1.55,
            overflow: TextOverflow.visible,
            color: ColorManager.textGrey,
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final ProductModel product;

  const _BottomActions({required this.product});

  @override
  Widget build(BuildContext context) {
 

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
        decoration: BoxDecoration(
    
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .08),
              blurRadius: 18,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            final isInCart = cartState.items.any(
              (item) => item.product.id == product.id,
            );

            return Row(
              children: [
                Expanded(
                  child: ButtonWidgetBorder(
                    title: context.tr('buy_now'),
                    radius: 12,
                    heightButton: 52,
                    colorButton: ColorManager.primaryColor,
                    colorTitle: ColorManager.primaryColor,
                    onTap: () {
                      context.read<CartCubit>().addProductIfNeeded(product);
                      ToWithFade(AppRoutes.cart);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ButtonWidget(
                    title:
                        isInCart
                            ? context.tr('added_to_cart')
                            : context.tr('add_to_cart'),
                    radius: 12,
                    heightButton: 52,
                    colorButton:
                        isInCart
                            ? ColorManager.greyColor
                            : ColorManager.primaryColor,
                    onTap:
                        isInCart
                            ? null
                            : () =>
                                context.read<CartCubit>().addProduct(product),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
