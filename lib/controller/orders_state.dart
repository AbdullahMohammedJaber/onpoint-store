import 'package:ecommerce_one/core/models/order_model.dart';
import 'package:equatable/equatable.dart';

class OrdersState extends Equatable {
  final List<OrderModel> orders;
  final String? message;

  const OrdersState({this.orders = const [], this.message});

  OrdersState copyWith({List<OrderModel>? orders, String? message}) {
    return OrdersState(orders: orders ?? this.orders, message: message);
  }

  @override
  List<Object?> get props => [orders, message];
}
