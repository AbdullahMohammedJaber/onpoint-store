import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/widgets/app_shimmer.dart';
import 'package:ecommerce_one/controller/home_cubit.dart';
import 'package:ecommerce_one/controller/home_state.dart';
import 'package:ecommerce_one/controller/products_cubit.dart';
import 'package:ecommerce_one/controller/search_cubit.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/screen/category/category_widget_tow.dart';
import 'package:ecommerce_one/screen/widget/app_bar_widget.dart';
import 'package:ecommerce_one/screen/widget/show_product.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

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
                  return const _HomeShimmer();
                }
                if (state.status == HomeStatus.failure) {
                  return _MessageState(
                    message: context.tr(state.errorMessage ?? 'unable_to_load'),
                    onRetry: () => context.read<HomeCubit>().loadHome(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => context.read<HomeCubit>().loadHome(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ...state.banners.map(
                          (banner) => Image.asset(banner.imageAsset),
                        ),
                        SizedBox(height: hi * 0.02),
                        CategoryWidgetTow(categories: state.categories),
                        SizedBox(height: hi * 0.02),
                        Image.asset("assets/test/banner.png"),
                        ShowProduct(
                          title: context.tr('discounted_products'),
                          products: state.discountedProducts,
                          discount: true,
                        ),
                        ShowProduct(
                          title: context.tr('popular_products'),
                          products: state.popularProducts,
                          expandedShowCart: true,
                        ),
                        ShowProduct(
                          title: context.tr('best_sellers'),
                          products: state.bestSellers,
                          expandedShowCart: true,
                        ),
                        SizedBox(height: hi * 0.02),
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

class _HomeShimmer extends StatelessWidget {
  const _HomeShimmer();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ShimmerBox(width: double.infinity, height: 120),
          SizedBox(height: 12),
          ShimmerBox(width: double.infinity, height: 120),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: ShimmerBox(width: double.infinity, height: 90)),
              SizedBox(width: 8),
              Expanded(child: ShimmerBox(width: double.infinity, height: 90)),
            ],
          ),
          SizedBox(height: 20),
          ShimmerBox(width: double.infinity, height: 220),
        ],
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _MessageState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultText(message, fontSize: 14, color: ColorManager.textGrey),
          const SizedBox(height: 12),
          TextButton(onPressed: onRetry, child: Text(context.tr('retry'))),
        ],
      ),
    );
  }
}
