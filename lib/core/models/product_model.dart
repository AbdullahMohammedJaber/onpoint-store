import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final String imageAsset;
  final String categoryId;
  final double rating;
  final int stock;
  final bool isPopular;
  final bool isBestSeller;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.imageAsset,
    required this.categoryId,
    required this.rating,
    required this.stock,
    this.isPopular = false,
    this.isBestSeller = false,
  });

  bool get hasDiscount => oldPrice != null && oldPrice! > price;

  int get discountPercent {
    if (!hasDiscount) return 0;
    return (((oldPrice! - price) / oldPrice!) * 100).round();
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    oldPrice,
    imageAsset,
    categoryId,
    rating,
    stock,
    isPopular,
    isBestSeller,
  ];
}
