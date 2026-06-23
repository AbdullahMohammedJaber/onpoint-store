import 'package:ecommerce_one/core/data/remote/auth/auth_data_surce.dart';
import 'package:ecommerce_one/core/data/request/auth/login_request.dart';
import 'package:ecommerce_one/core/data/request/auth/signup_request.dart';
import 'package:ecommerce_one/core/server/result.dart';
import 'package:ecommerce_one/utils/services/string.dart';

abstract class AuthRepo {
  Future<ApiResult<Map<String, dynamic>>> login({
    required LoginRequestModel loginRequestModel,
  });
  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequestModel signupRequestModel,
  });
}

class AuthRepoImpl extends AuthRepo {
  AuthDataSurceImpl authDataSurceImpl;
  AuthRepoImpl(this.authDataSurceImpl);
  @override
  Future<ApiResult<Map<String, dynamic>>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      final result = await authDataSurceImpl.login(
        loginRequestModel: loginRequestModel,
      );
      if (result.isFailed) {
        return ApiResult.failed(message: result.message);
      } else if (result.isNoInternet) {
        return ApiResult.noInternet(message: StringApp.noInternet);
      } else {
        return ApiResult.success(result.data!);
      }
    } catch (e) {
      return ApiResult.failed(message: e.toString());
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequestModel signupRequestModel,
  }) async {
    try {
      final result = await authDataSurceImpl.signup(
        signupRequestModel: signupRequestModel,
      );

      if (result.isFailed) {
        if (result.message == null) {
          return ApiResult.failed(message: result.data!['title']);
        } else {
          return ApiResult.failed(message: result.message);
        }
      } else if (result.isNoInternet) {
        return ApiResult.noInternet(message: StringApp.noInternet);
      } else {
        return ApiResult.success(result.data!);
      }
    } catch (e) {
      return ApiResult.failed(message: e.toString());
    }
  }
}
