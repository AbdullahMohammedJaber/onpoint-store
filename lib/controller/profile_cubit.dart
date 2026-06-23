import 'package:ecommerce_one/core/mock_data/mock_catalog_repository.dart';
import 'package:ecommerce_one/core/models/user_model.dart';
import 'package:ecommerce_one/controller/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final MockCatalogRepository repository;
  UserModel? _mockUser;

  ProfileCubit({required this.repository}) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = _mockUser ?? await repository.getProfile();
      _mockUser = user;
      emit(state.copyWith(status: ProfileStatus.success, user: user));
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'unable_to_load_profile',
        ),
      );
    }
  }

  void startEditing() {
    emit(state.copyWith(isEditing: true));
  }

  void cancelEditing() {
    emit(state.copyWith(isEditing: false));
  }

  Future<void> saveProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    if (name.trim().isEmpty || email.trim().isEmpty || phone.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'fill_required_fields'));
      return;
    }

    emit(state.copyWith(isSaving: true));
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final current = state.user;
    if (current == null) {
      emit(
        state.copyWith(isSaving: false, errorMessage: 'profile_save_failed'),
      );
      return;
    }

    final updated = current.copyWith(
      name: name.trim(),
      email: email.trim(),
      phone: phone.trim(),
    );
    _mockUser = updated;
    emit(
      state.copyWith(
        status: ProfileStatus.success,
        user: updated,
        isEditing: false,
        isSaving: false,
        message: 'profile_saved',
      ),
    );
  }
}
