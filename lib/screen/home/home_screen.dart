import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/widgets/app_shimmer.dart';
import 'package:ecommerce_one/controller/home_cubit.dart';
import 'package:ecommerce_one/controller/home_state.dart';
import 'package:ecommerce_one/controller/products_cubit.dart';
import 'package:ecommerce_one/controller/search_cubit.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/screen/widget/show_product.dart';
import 'package:ecommerce_one/screen/widget/app_bar_widget.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        children: [
          AppBarWidget(
            search: true,
            onSearch: (value) {
              context.read<SearchCubit>().search(value);
              context.read<ProductsCubit>().search(value);
              ToWithFade(AppRoutes.allProduct);
            },
          ),
          SizedBox(height: hi * 0.02),

          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.status == HomeStatus.loading) {
                  return const _SimpleHomeShimmer();
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset("assets/test/banner.png"),
                      ShowProduct(
                        title: context.tr('popular_products'),
                        products: state.popularProducts,
                      ),
                      SizedBox(height: hi * 0.02),
                      Image.asset("assets/test/banner.png"),
                      ShowProduct(
                        title: context.tr('discounted_products'),
                        products: state.discountedProducts,
                        discount: true,
                      ),
                      SizedBox(height: hi * 0.03),
                    ],
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

class _SimpleHomeShimmer extends StatelessWidget {
  const _SimpleHomeShimmer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ShimmerBox(width: double.infinity, height: 160),
          SizedBox(height: 16),
          ShimmerBox(width: double.infinity, height: 240),
        ],
      ),
    );
  }
}
