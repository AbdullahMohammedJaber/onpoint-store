import 'package:ecommerce_one/core/models/category_model.dart';
import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:equatable/equatable.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final String query;
  final String? categoryId;
  final double minPrice;
  final double maxPrice;
  final String? errorMessage;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.query = '',
    this.categoryId,
    this.minPrice = 0,
    this.maxPrice = 20000,
    this.errorMessage,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    String? query,
    String? categoryId,
    bool clearCategory = false,
    double? minPrice,
    double? maxPrice,
    String? errorMessage,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      query: query ?? this.query,
      categoryId: clearCategory ? null : categoryId ?? this.categoryId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    products,
    categories,
    query,
    categoryId,
    minPrice,
    maxPrice,
    errorMessage,
  ];
}
