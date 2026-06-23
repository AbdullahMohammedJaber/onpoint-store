import 'package:ecommerce_one/core/data/request/auth/login_request.dart';
import 'package:ecommerce_one/core/data/request/auth/signup_request.dart';
import 'package:ecommerce_one/core/domain/repo/auth/auth_repo.dart';
import 'package:ecommerce_one/core/server/result.dart';

class AuthUseCase {
  AuthRepoImpl authRepoImpl;
  AuthUseCase(this.authRepoImpl);

  Future<ApiResult<Map<String, dynamic>>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    return authRepoImpl.login(loginRequestModel: loginRequestModel);
  }

  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequestModel signupRequestModel,
  }) async {
    return authRepoImpl.signup(signupRequestModel: signupRequestModel);
  }
}
