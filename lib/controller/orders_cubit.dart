import 'package:ecommerce_one/core/models/cart_item_model.dart';
import 'package:ecommerce_one/core/models/order_model.dart';
import 'package:ecommerce_one/controller/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersState());

  OrderModel? createOrder({
    required List<CartItemModel> items,
    required double subtotal,
    required double shipping,
    required double discount,
  }) {
    if (items.isEmpty) {
      emit(state.copyWith(message: 'cart_empty'));
      return null;
    }

    final order = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      items: List<CartItemModel>.unmodifiable(items),
      subtotal: subtotal,
      shipping: shipping,
      discount: discount,
      status: OrderStatus.confirmed,
    );
    emit(
      state.copyWith(
        orders: [order, ...state.orders],
        message: 'order_created',
      ),
    );
    return order;
  }
}
