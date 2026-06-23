// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:ecommerce_one/core/data/request/auth/login_request.dart';
import 'package:ecommerce_one/core/data/request/auth/signup_request.dart';
import 'package:ecommerce_one/core/user_case_state/user_case_state.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/string.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  closeAllLoading() {
    emit(AuthState.closeAllLoading());
  }

  // TODO login functions
  Future<void> login(LoginRequestModel loginRequestModel) async {
    emit(state.copyWith(loading: true));
    final result = await UserCaseState().authUserCase.login(
      loginRequestModel: loginRequestModel,
    );
    emit(state.copyWith(loading: false));

    result.handle(
      onSuccess: (data) {},
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  // TODO signup functions
  Future<void> signup(SignupRequestModel signupRequestModel) async {
    emit(state.copyWith(loading: true));
    final result = await UserCaseState().authUserCase.signup(
      signupRequestModel: signupRequestModel,
    );
    emit(state.copyWith(loading: false));

    result.handle(
      onSuccess: (data) {},
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  showUnShowPassword() {
    bool show = !state.obscureText;
    emit(state.copyWith(obscureText: show));
  }
}
