import 'package:ecommerce_one/core/models/banner_model.dart';
import 'package:ecommerce_one/core/models/category_model.dart';
import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<ProductModel> discountedProducts;
  final List<ProductModel> popularProducts;
  final List<ProductModel> bestSellers;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.banners = const [],
    this.categories = const [],
    this.discountedProducts = const [],
    this.popularProducts = const [],
    this.bestSellers = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<BannerModel>? banners,
    List<CategoryModel>? categories,
    List<ProductModel>? discountedProducts,
    List<ProductModel>? popularProducts,
    List<ProductModel>? bestSellers,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      discountedProducts: discountedProducts ?? this.discountedProducts,
      popularProducts: popularProducts ?? this.popularProducts,
      bestSellers: bestSellers ?? this.bestSellers,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    banners,
    categories,
    discountedProducts,
    popularProducts,
    bestSellers,
    errorMessage,
  ];
}
