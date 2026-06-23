import 'package:ecommerce_one/core/models/product_model.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/screen/auth/create_account.dart';
import 'package:ecommerce_one/screen/auth/login_screen.dart';
import 'package:ecommerce_one/screen/auth/reset_password.dart';
import 'package:ecommerce_one/screen/auth/verification_code_screen.dart';
import 'package:ecommerce_one/screen/cart/cart_screen.dart';
import 'package:ecommerce_one/screen/favorites/favorites_screen.dart';
import 'package:ecommerce_one/screen/home/home_screen.dart';
import 'package:ecommerce_one/screen/home/home_screen2.dart';
import 'package:ecommerce_one/screen/orders/orders_screen.dart';
import 'package:ecommerce_one/screen/product/all_product.dart';
import 'package:ecommerce_one/screen/product/product_details_screen.dart';
import 'package:ecommerce_one/screen/root/root_app.dart';
import 'package:ecommerce_one/screen/setting/setting_screen.dart';
import 'package:ecommerce_one/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Widget getPage(String routeName, [Object? arguments]) {
    switch (routeName) {
      case AppRoutes.splash:
        return SplashScreen();
      case AppRoutes.homeScreenT:
        return HomeScreen2();
      case AppRoutes.settingsScreen:
        return SettingScreen();
      case AppRoutes.login:
        return LoginScreen();
      case AppRoutes.homeScreen:
        return HomeScreen();
      case AppRoutes.resetPasswordScreen:
        return ResetPasswordScreen();
      case AppRoutes.verificationCodeScreen:
        return VerificationCodeScreen();
      case AppRoutes.createAccountScreen:
        return CreateAccountScreen();
      case AppRoutes.root:
        return RootApp();
      case AppRoutes.allProduct:
        return AllProductScreen();
      case AppRoutes.cart:
        return CartScreen(showBackButton: true);
      case AppRoutes.productDetails:
        return ProductDetailsScreen(product: arguments as ProductModel);
      case AppRoutes.favorites:
        return FavoritesScreen();
      case AppRoutes.orders:
        return OrdersScreen();
      default:
        return const LoginScreen();
    }
  }
}
