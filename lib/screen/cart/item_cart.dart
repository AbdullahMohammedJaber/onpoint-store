import 'package:ecommerce_one/core/models/cart_item_model.dart';
import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/controller/cart_cubit.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCart extends StatelessWidget {
  final CartItemModel item;

  const ItemCart({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: wi * 0.30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Center(
                  child: Image.asset(item.product.imageAsset, height: 70),
                ),
              ),
              SizedBox(width: wi * 0.04),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      item.product.name,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: hi * 0.013),
                    Row(
                      children: [
                        DefaultText(
                          "${context.tr('color')} : ",
                          fontSize: 9.5,
                          fontWeight: FontWeight.w400,
                        ),
                        DefaultText(
                          "red",
                          fontSize: 9.5,
                          color: ColorManager.textGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: hi * 0.0015),

                    Row(
                      children: [
                        DefaultText(
                          "${context.tr('size')} : ",
                          fontSize: 9.5,
                          fontWeight: FontWeight.w400,
                        ),
                        DefaultText(
                          "small",
                          fontSize: 9.5,
                          color: ColorManager.textGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.transparent,
                child: Center(
                  child: GestureDetector(
                    onTap:
                        () => context.read<CartCubit>().removeProduct(
                          item.product.id,
                        ),
                    child: SvgPicture.asset("assets/icons/trash.svg"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: hi * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 45,
                width: wi * 0.30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorManager.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:
                            () => context.read<CartCubit>().decreaseQuantity(
                              item.product.id,
                            ),
                        child: Container(
                          height: 45,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color(0xffBCBCBC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: SvgPicture.asset("assets/icons/minus.svg"),
                          ),
                        ),
                      ),
                      Spacer(),
                      DefaultText(
                        item.quantity.toString(),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),

                      GestureDetector(
                        onTap:
                            () => context.read<CartCubit>().increaseQuantity(
                              item.product.id,
                            ),
                        child: Container(
                          height: 45,
                          width: 40,
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: SvgPicture.asset("assets/icons/plus.svg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: wi * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    context.tr('individual_price'),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.textGrey,
                  ),
                  DefaultText(
                    "\$${item.product.price.toStringAsFixed(2)}",
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.primaryColor,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    context.tr('total_price'),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.textGrey,
                  ),
                  DefaultText(
                    "\$${item.totalPrice.toStringAsFixed(2)}",
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.primaryColor,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: hi * 0.01),
          Divider(color: ColorManager.greyColor, thickness: 0.5),
        ],
      ),
    );
  }
}
