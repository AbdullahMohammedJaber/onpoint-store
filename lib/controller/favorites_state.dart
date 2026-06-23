import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<ProductModel> products;
  final String? message;

  const FavoritesState({this.products = const [], this.message});

  bool isFavorite(String productId) {
    return products.any((product) => product.id == productId);
  }

  FavoritesState copyWith({List<ProductModel>? products, String? message}) {
    return FavoritesState(
      products: products ?? this.products,
      message: message,
    );
  }

  @override
  List<Object?> get props => [products, message];
}
