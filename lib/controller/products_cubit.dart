import 'package:ecommerce_one/core/mock_data/mock_catalog_repository.dart';
import 'package:ecommerce_one/controller/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final MockCatalogRepository repository;

  ProductsCubit({required this.repository}) : super(const ProductsState());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final results = await repository.getProducts(
        query: state.query,
        categoryId: state.categoryId,
        minPrice: state.minPrice,
        maxPrice: state.maxPrice,
      );
      final categories = await repository.getCategories();
      emit(
        state.copyWith(
          status: ProductsStatus.success,
          products: results,
          categories: categories,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: 'unable_to_load_products',
        ),
      );
    }
  }

  Future<void> search(String query) async {
    emit(state.copyWith(query: query));
    await loadProducts();
  }

  Future<void> applyFilters({
    String? categoryId,
    required double minPrice,
    required double maxPrice,
  }) async {
    emit(
      state.copyWith(
        categoryId: categoryId,
        clearCategory: categoryId == null,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );
    await loadProducts();
  }

  Future<void> clearFilters() async {
    emit(state.copyWith(clearCategory: true, minPrice: 0, maxPrice: 20000));
    await loadProducts();
  }
}
