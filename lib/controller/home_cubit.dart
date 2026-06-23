import 'package:ecommerce_one/core/mock_data/mock_catalog_repository.dart';
import 'package:ecommerce_one/controller/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final MockCatalogRepository repository;

  HomeCubit({required this.repository}) : super(const HomeState());

  Future<void> loadHome() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final data = await repository.getHomeData();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          banners: data.banners,
          categories: data.categories,
          discountedProducts: data.discountedProducts,
          popularProducts: data.popularProducts,
          bestSellers: data.bestSellers,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'unable_to_load_home',
        ),
      );
    }
  }
}
