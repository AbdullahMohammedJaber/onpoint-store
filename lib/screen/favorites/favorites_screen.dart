import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/widgets/app_title_bar.dart';
import 'package:ecommerce_one/controller/favorites_cubit.dart';
import 'package:ecommerce_one/controller/favorites_state.dart';
import 'package:ecommerce_one/screen/widget/item_product.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/services/grid_view_custom.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(title: context.tr('favorites')),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: DefaultText(
                  context.tr('favorites_empty'),
                  fontSize: 14,
                  color: ColorManager.textGrey,
                ),
              ),
            );
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Padding(
              key: ValueKey(state.products.length),
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      height: hi * 0.32,
                      mainAxisSpacing: 2,
                    ),
                itemCount: state.products.length,
                itemBuilder:
                    (_, index) => ItemProduct(
                      product: state.products[index],
                      discount: state.products[index].hasDiscount,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
