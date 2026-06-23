import 'package:ecommerce_one/core/mock_data/mock_catalog_repository.dart';
import 'package:ecommerce_one/controller/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final MockCatalogRepository repository;

  SearchCubit({required this.repository}) : super(const SearchState());

  Future<void> search(String query) async {
    emit(state.copyWith(status: SearchStatus.loading, query: query));
    try {
      final results = await repository.getProducts(query: query);
      emit(state.copyWith(status: SearchStatus.success, results: results));
    } catch (_) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: 'unable_to_search',
        ),
      );
    }
  }
}
