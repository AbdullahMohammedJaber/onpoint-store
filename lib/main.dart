import 'package:device_preview/device_preview.dart';
import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/mock_data/mock_catalog_repository.dart';
import 'package:ecommerce_one/controller/auth_cubit.dart';
import 'package:ecommerce_one/controller/network_cubit.dart';
import 'package:ecommerce_one/controller/cart_cubit.dart';
import 'package:ecommerce_one/controller/cart_state.dart';
import 'package:ecommerce_one/controller/favorites_cubit.dart';
import 'package:ecommerce_one/controller/favorites_state.dart';
import 'package:ecommerce_one/controller/home_cubit.dart';
import 'package:ecommerce_one/controller/orders_cubit.dart';
import 'package:ecommerce_one/controller/orders_state.dart';
import 'package:ecommerce_one/controller/products_cubit.dart';
import 'package:ecommerce_one/controller/profile_cubit.dart';
import 'package:ecommerce_one/controller/profile_state.dart';
import 'package:ecommerce_one/controller/search_cubit.dart';
import 'package:ecommerce_one/controller/app_settings_cubit.dart';
import 'package:ecommerce_one/controller/app_settings_state.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/navigation_server.dart';
import 'package:ecommerce_one/route/router_manager.dart';
import 'package:ecommerce_one/utils/services/toast_service.dart';
import 'package:ecommerce_one/utils/theme/theme_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: AppLocales.supported,
      path: AppLocales.path,
      fallbackLocale: AppLocales.en,
      startLocale: AppLocales.en,
      child: DevicePreview(
        builder:
            (context) => BlocProvider(
              create: (_) => NetworkCubit(),
              child: const MyApp(),
            ),
        enabled: !kReleaseMode,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const repository = MockCatalogRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(repository: repository)..loadHome(),
        ),
        BlocProvider<ProductsCubit>(
          create:
              (context) =>
                  ProductsCubit(repository: repository)..loadProducts(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(repository: repository),
        ),
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
        BlocProvider<FavoritesCubit>(create: (context) => FavoritesCubit()),
        BlocProvider<OrdersCubit>(create: (context) => OrdersCubit()),
        BlocProvider<ProfileCubit>(
          create:
              (context) => ProfileCubit(repository: repository)..loadProfile(),
        ),
        BlocProvider<AppSettingsCubit>(create: (context) => AppSettingsCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listenWhen:
                (previous, current) => previous.message != current.message,
            listener: (context, state) {
              if (state.message != null) {
                showMessage(state.message!, value: true);
              }
            },
          ),
          BlocListener<FavoritesCubit, FavoritesState>(
            listenWhen:
                (previous, current) => previous.message != current.message,
            listener: (context, state) {
              if (state.message != null) {
                showMessage(state.message!, value: true);
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listenWhen:
                (previous, current) => previous.message != current.message,
            listener: (context, state) {
              if (state.message != null) {
                showMessage(state.message!, value: true);
              }
            },
          ),
          BlocListener<ProfileCubit, ProfileState>(
            listenWhen:
                (previous, current) =>
                    previous.message != current.message ||
                    previous.errorMessage != current.errorMessage,
            listener: (context, state) {
              if (state.message != null) {
                showMessage(state.message!, value: true);
              }
              if (state.errorMessage != null) {
                showMessage(state.errorMessage!, value: false);
              }
            },
          ),
        ],
        child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
          builder: (context, settings) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: MaterialApp(
                key: ValueKey(
                  '${settings.themeMode}-${context.locale.languageCode}',
                ),
                debugShowCheckedModeBanner: false,
                title: 'E-Commerce',
                theme: getApplicationTheme(),
                darkTheme: getDarkApplicationTheme(),
                themeMode: settings.themeMode,
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                initialRoute: AppRoutes.splash,
                navigatorKey: NavigationService.navigatorKey,
                onGenerateRoute: AppRouter.generateRoute,
              ),
            );
          },
        ),
      ),
    );
  }
}
