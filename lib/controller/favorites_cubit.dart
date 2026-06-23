import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:ecommerce_one/controller/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggleFavorite(ProductModel product) {
    if (state.isFavorite(product.id)) {
      emit(
        state.copyWith(
          products:
              state.products.where((item) => item.id != product.id).toList(),
          message: 'favorite_removed',
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        products: [...state.products, product],
        message: 'favorite_added',
      ),
    );
  }
}
