import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/widgets/app_shimmer.dart';
import 'package:ecommerce_one/screen/filter/filter_screen.dart';
import 'package:ecommerce_one/screen/widget/app_bar_widget.dart';
import 'package:ecommerce_one/screen/widget/item_product.dart';
import 'package:ecommerce_one/controller/products_cubit.dart';
import 'package:ecommerce_one/controller/products_state.dart';
import 'package:ecommerce_one/controller/search_cubit.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/services/grid_view_custom.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    final query = context.read<ProductsCubit>().state.query;
    searchController = TextEditingController(text: query);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      drawer: FilterDrawer(),
      body: Column(
        children: [
          AppBarWidget(
            search: true,
            filter: true,
            canBack: true,
            controller: searchController,
            onSearch: (value) {
              context.read<SearchCubit>().search(value);
              context.read<ProductsCubit>().search(value);
            },
            onTapFilter: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          SizedBox(height: hi * 0.03),
          Expanded(
            child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state.status == ProductsStatus.loading) {
                  return const ProductGridShimmer();
                }
                if (state.status == ProductsStatus.failure) {
                  return _MessageState(
                    message: context.tr(
                      state.errorMessage ?? 'unable_to_load_products',
                    ),
                    onRetry: () => context.read<ProductsCubit>().loadProducts(),
                  );
                }
                if (state.products.isEmpty) {
                  return _MessageState(
                    message: context.tr('no_matching_products'),
                    onRetry: () => context.read<ProductsCubit>().clearFilters(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => context.read<ProductsCubit>().loadProducts(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
          ),
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
          TextButton(onPressed: onRetry, child: Text(context.tr('reset'))),
        ],
      ),
    );
  }
}
