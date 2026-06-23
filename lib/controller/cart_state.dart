import 'package:ecommerce_one/core/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';

enum CartStatus { initial, ready, failure }

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItemModel> items;
  final String? message;

  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.message,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping => items.isEmpty ? 0 : 10;
  double get discount => subtotal >= 500 ? subtotal * 0.1 : 0;
  double get total => subtotal + shipping - discount;
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({
    CartStatus? status,
    List<CartItemModel>? items,
    String? message,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, items, message];
}
