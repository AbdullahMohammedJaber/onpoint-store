// ignore_for_file: deprecated_member_use

import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/models/category_model.dart';
import 'package:ecommerce_one/controller/products_cubit.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryWidgetTow extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoryWidgetTow({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: wi,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DefaultText(
              context.tr('top_categories'),
              color: ColorManager.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 3),
            DefaultText(
              context.tr('product_categories'),
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: hi * 0.01),
            SizedBox(
              height: hi * 0.15,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,

                itemBuilder: (context, index) {
                  final category = categories[index];
                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 180 + index * 40),
                    tween: Tween(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(12 * (1 - value), 0),
                          child: child,
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        context.read<ProductsCubit>().applyFilters(
                          categoryId: category.id,
                          minPrice: 0,
                          maxPrice: 20000,
                        );
                        ToWithFade(AppRoutes.allProduct);
                      },
                      child: Card(
                        elevation: 0.3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: wi * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorManager.primaryColor
                                      .withOpacity(0.3),
                                  child: SvgPicture.asset(category.iconAsset),
                                ),
                                SizedBox(height: 5),
                                DefaultText(
                                  category.name,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(height: 3),

                                DefaultText(
                                  context.tr('products'),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.textGrey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: wi * 0.01);
                },
                itemCount: categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
