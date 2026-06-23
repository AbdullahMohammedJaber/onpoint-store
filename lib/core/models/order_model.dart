import 'package:ecommerce_one/core/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';

enum OrderStatus { pending, confirmed, shipped, delivered }

class OrderModel extends Equatable {
  final String id;
  final DateTime createdAt;
  final List<CartItemModel> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final OrderStatus status;

  const OrderModel({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.status,
  });

  double get total => subtotal + shipping - discount;

  @override
  List<Object?> get props => [
    id,
    createdAt,
    items,
    subtotal,
    shipping,
    discount,
    status,
  ];
}
