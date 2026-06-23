import 'dart:async';

import 'package:ecommerce_one/core/models/banner_model.dart';
import 'package:ecommerce_one/core/models/category_model.dart';
import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:ecommerce_one/core/models/user_model.dart';

class HomeMockData {
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<ProductModel> discountedProducts;
  final List<ProductModel> popularProducts;
  final List<ProductModel> bestSellers;

  const HomeMockData({
    required this.banners,
    required this.categories,
    required this.discountedProducts,
    required this.popularProducts,
    required this.bestSellers,
  });
}

class MockCatalogRepository {
  const MockCatalogRepository();

  Future<HomeMockData> getHomeData() async {
    await _fakeDelay();
    return HomeMockData(
      banners: banners,
      categories: categories,
      discountedProducts:
          products.where((product) => product.hasDiscount).toList(),
      popularProducts: products.where((product) => product.isPopular).toList(),
      bestSellers: products.where((product) => product.isBestSeller).toList(),
    );
  }

  Future<List<ProductModel>> getProducts({
    String query = '',
    String? categoryId,
    double? minPrice,
    double? maxPrice,
  }) async {
    await _fakeDelay();
    final normalizedQuery = query.trim().toLowerCase();

    return products.where((product) {
      final matchesQuery =
          normalizedQuery.isEmpty ||
          product.name.toLowerCase().contains(normalizedQuery) ||
          product.description.toLowerCase().contains(normalizedQuery);
      final matchesCategory =
          categoryId == null || product.categoryId == categoryId;
      final matchesMin = minPrice == null || product.price >= minPrice;
      final matchesMax = maxPrice == null || product.price <= maxPrice;
      return matchesQuery && matchesCategory && matchesMin && matchesMax;
    }).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    await _fakeDelay();
    return categories;
  }

  Future<ProductModel?> getProductById(String id) async {
    await _fakeDelay();
    for (final product in products) {
      if (product.id == id) return product;
    }
    return null;
  }

  Future<UserModel> getProfile() async {
    await _fakeDelay();
    return const UserModel(
      name: 'Ahmad Samer Ali',
      email: 'user@gmail.com',
      phone: '+963 4563 2548 52',
      avatarAsset: 'assets/test/user.png',
    );
  }

  Future<void> _fakeDelay() =>
      Future<void>.delayed(const Duration(milliseconds: 250));

  static const List<BannerModel> banners = [
    BannerModel(id: 'banner-1', imageAsset: 'assets/test/ban1.png'),
    BannerModel(id: 'banner-2', imageAsset: 'assets/test/ban2.png'),
    BannerModel(id: 'banner-3', imageAsset: 'assets/test/ban3.png'),
    BannerModel(id: 'banner-4', imageAsset: 'assets/test/ban4.png'),
  ];

  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'electronics',
      name: 'Electronics & Technology',
      iconAsset: 'assets/test/devices.svg',
    ),
    CategoryModel(
      id: 'fashion',
      name: 'Fashion',
      iconAsset: 'assets/test/devices.svg',
    ),
    CategoryModel(
      id: 'home',
      name: 'Home Appliances',
      iconAsset: 'assets/test/devices.svg',
    ),
    CategoryModel(
      id: 'sports',
      name: 'Sports',
      iconAsset: 'assets/test/devices.svg',
    ),
  ];

  static const List<ProductModel> products = [
    ProductModel(
      id: 'p1',
      name: 'Mac Book Pro 14',
      description:
          'Powerful laptop with a bright display, fast storage, and all-day battery life.',
      price: 1299.99,
      oldPrice: 1499.99,
      imageAsset: 'assets/test/product.png',
      categoryId: 'electronics',
      rating: 4.8,
      stock: 8,
      isPopular: true,
      isBestSeller: true,
    ),
    ProductModel(
      id: 'p2',
      name: 'Apple Watch Ultra 2',
      description:
          'Premium smartwatch with durable case, fitness tracking, and long battery life.',
      price: 799,
      oldPrice: 899,
      imageAsset: 'assets/test/product.png',
      categoryId: 'electronics',
      rating: 4.7,
      stock: 15,
      isPopular: true,
    ),
    ProductModel(
      id: 'p3',
      name: 'Wireless Headphones',
      description:
          'Noise cancelling headphones with rich sound and comfortable ear cushions.',
      price: 149.5,
      imageAsset: 'assets/test/product.png',
      categoryId: 'electronics',
      rating: 4.5,
      stock: 25,
      isBestSeller: true,
    ),
    ProductModel(
      id: 'p4',
      name: 'Smart Pool Cleaner',
      description:
          'Sweeps the bottom, walls, and water line for pools up to 100 square meters.',
      price: 450.55,
      oldPrice: 520,
      imageAsset: 'assets/test/product.png',
      categoryId: 'home',
      rating: 4.4,
      stock: 6,
      isPopular: true,
    ),
    ProductModel(
      id: 'p5',
      name: 'Running Shoes',
      description:
          'Lightweight sport shoes with breathable upper and cushioned sole.',
      price: 89.99,
      imageAsset: 'assets/test/product.png',
      categoryId: 'sports',
      rating: 4.2,
      stock: 30,
      isBestSeller: true,
    ),
    ProductModel(
      id: 'p6',
      name: 'Classic Cotton Jacket',
      description:
          'Comfortable everyday jacket with clean stitching and modern fit.',
      price: 64.99,
      oldPrice: 79.99,
      imageAsset: 'assets/test/product.png',
      categoryId: 'fashion',
      rating: 4.1,
      stock: 18,
      isPopular: true,
    ),
    ProductModel(
      id: 'p7',
      name: 'Smart Home Speaker',
      description:
          'Compact speaker with clear audio and smart assistant support.',
      price: 59.99,
      imageAsset: 'assets/test/product.png',
      categoryId: 'home',
      rating: 4.3,
      stock: 20,
      isBestSeller: true,
    ),
    ProductModel(
      id: 'p8',
      name: 'Fitness Tracker Band',
      description:
          'Tracks daily steps, sleep, workouts, and heart rate in a slim design.',
      price: 39.99,
      oldPrice: 49.99,
      imageAsset: 'assets/test/product.png',
      categoryId: 'sports',
      rating: 4,
      stock: 40,
      isPopular: true,
    ),
  ];
}
