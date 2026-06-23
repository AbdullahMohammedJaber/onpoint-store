import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/utils/services/button_widget.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:ecommerce_one/controller/products_cubit.dart';
import 'package:ecommerce_one/controller/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  RangeValues priceRange = const RangeValues(0, 20000);
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: wi * 0.85,
        color: Theme.of(context).cardColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              Divider(thickness: 0.5, color: ColorManager.greyColor),
              SizedBox(height: hi * 0.02),

              _category(),
              SizedBox(height: hi * 0.02),
              Divider(thickness: 0.5, color: ColorManager.greyColor),
              _priceRange(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            context.tr('product_category'),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 16),

          /// All Categories
          _categoryItem(
            title: "${context.tr('all_categories')} (50)",
            value: selectedCategoryId == null,
            onChanged: (_) {
              setState(() => selectedCategoryId = null);
            },
          ),

          const SizedBox(height: 20),

          /// Grid Categories
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 3.2,
                ),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return _categoryItem(
                    title: category.name,
                    value: selectedCategoryId == category.id,
                    onChanged: (_) {
                      setState(() => selectedCategoryId = category.id);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _categoryItem({
    required String title,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400, width: 2),
            ),
            child: value ? const Icon(Icons.check, size: 18) : const SizedBox(),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: DefaultText(
              title,
              fontSize: 12,
              color: ColorManager.textGrey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRange() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultText(
                context.tr('price_range'),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 20000,
            activeColor: ColorManager.primaryDarkColor,
            labels: RangeLabels(
              "\$${priceRange.start.toInt()}",
              "\$${priceRange.end.toInt()}",
            ),

            onChanged: (values) {
              setState(() => priceRange = values);
            },
          ),
          Row(
            children: [
              SizedBox(
                width: wi * 0.25,
                child: ButtonWidget(
                  title: context.tr('filter'),
                  radius: 8,
                  heightButton: 40,
                  colorButton: ColorManager.primaryDarkColor,
                  onTap: () {
                    context.read<ProductsCubit>().applyFilters(
                      categoryId: selectedCategoryId,
                      minPrice: priceRange.start,
                      maxPrice: priceRange.end,
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
              Spacer(),
              DefaultText(
                "${context.tr('price')} :",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              DefaultText(
                " \$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorManager.primaryDarkColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Spacer(),
        DefaultText(
          context.tr('search_filters'),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        Spacer(),
      ],
    );
  }
}
