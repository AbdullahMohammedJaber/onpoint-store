import 'package:ecommerce_one/core/models/cart_item_model.dart';
import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:ecommerce_one/controller/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(status: CartStatus.ready));

  bool containsProduct(String productId) {
    return state.items.any((item) => item.product.id == productId);
  }

  bool addProduct(ProductModel product) {
    final items = [...state.items];
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      emit(
        state.copyWith(
          status: CartStatus.ready,
          message: 'already_cart_message',
        ),
      );
      return false;
    }

    items.add(CartItemModel(product: product, quantity: 1));
    emit(
      state.copyWith(
        status: CartStatus.ready,
        items: items,
        message: 'added_cart_message',
      ),
    );
    return true;
  }

  bool addProductIfNeeded(ProductModel product) {
    if (containsProduct(product.id)) {
      emit(
        state.copyWith(
          status: CartStatus.ready,
          message: 'already_cart_message',
        ),
      );
      return false;
    }
    return addProduct(product);
  }

  void removeProduct(String productId) {
    emit(
      state.copyWith(
        status: CartStatus.ready,
        items:
            state.items.where((item) => item.product.id != productId).toList(),
        message: 'removed_cart_message',
      ),
    );
  }

  void increaseQuantity(String productId) {
    final items =
        state.items.map((item) {
          if (item.product.id != productId) return item;
          final nextQuantity =
              item.quantity < item.product.stock
                  ? item.quantity + 1
                  : item.quantity;
          return item.copyWith(quantity: nextQuantity);
        }).toList();
    emit(state.copyWith(status: CartStatus.ready, items: items));
  }

  void decreaseQuantity(String productId) {
    final items = <CartItemModel>[];
    for (final item in state.items) {
      if (item.product.id == productId && item.quantity <= 1) {
        continue;
      }
      items.add(
        item.product.id == productId
            ? item.copyWith(quantity: item.quantity - 1)
            : item,
      );
    }
    emit(state.copyWith(status: CartStatus.ready, items: items));
  }

  void clearCart({bool silent = false}) {
    emit(
      state.copyWith(
        status: CartStatus.ready,
        items: const [],
        message: silent ? null : 'cart_cleared',
      ),
    );
  }
}
