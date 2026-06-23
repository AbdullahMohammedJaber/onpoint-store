part of 'auth_cubit.dart';

@immutable
class AuthState {
  //TODO Login Section State
  final bool loading;
  final bool obscureText;
  const AuthState({this.loading = false, this.obscureText = true});

  AuthState copyWith({
    //TODO Login Section State
    bool? loading,
    bool? obscureText,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      obscureText: obscureText ?? this.obscureText,
    );
  }

  factory AuthState.closeAllLoading() {
    return AuthState(loading: false, obscureText: true);
  }
}
