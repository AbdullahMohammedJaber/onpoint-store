import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/screen/widget/item_product.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';

class ShowProduct extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  final bool discount;
  final bool expandedShowCart;
  const ShowProduct({
    super.key,
    required this.title,
    required this.products,
    this.discount = false,
    this.expandedShowCart = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: hi * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                DefaultText(title, fontSize: 16, fontWeight: FontWeight.w500),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    ToWithFade(AppRoutes.allProduct);
                  },
                  child: DefaultText(
                    context.tr('see_all'),
                    fontSize: 12,
                    color: ColorManager.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: hi * 0.01),
          if (products.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: DefaultText(
                context.tr('no_products'),
                fontSize: 12,
                color: ColorManager.textGrey,
              ),
            )
          else if (expandedShowCart)
            SizedBox(
              width: wi,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        products
                            .take(4)
                            .map(
                              (product) => Padding(
                                padding: EdgeInsetsDirectional.only(
                                  end: wi * 0.01,
                                ),
                                child: ItemProduct(
                                  product: product,
                                  discount: discount,
                                  expandedShowCart: true,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            )
          else
            SizedBox(
              width: wi,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        products
                            .map(
                              (product) => Padding(
                                padding: EdgeInsetsDirectional.only(
                                  end: wi * 0.01,
                                ),
                                child: ItemProduct(
                                  product: product,
                                  discount: discount,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
