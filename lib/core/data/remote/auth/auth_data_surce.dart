import 'package:ecommerce_one/core/data/request/auth/login_request.dart';
import 'package:ecommerce_one/core/data/request/auth/signup_request.dart';
import 'package:ecommerce_one/core/server/dio_helper.dart';
import 'package:ecommerce_one/core/server/result.dart';
import 'package:ecommerce_one/core/server/servise.dart';
import 'package:ecommerce_one/utils/enum/enum_servicev.dart';

abstract class AuthDataSurce {
  Future<ApiResult<Map<String, dynamic>>> login({
    required LoginRequestModel loginRequestModel,
  });
  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequestModel signupRequestModel,
  });
}

class AuthDataSurceImpl extends AuthDataSurce {
  DioClient dioClient;
  AuthDataSurceImpl(this.dioClient);
  @override
  Future<ApiResult<Map<String, dynamic>>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    return await dioClient.request(
      path: ApiService.login,
      method: RequestMethode.POST.name,
      data: loginRequestModel.toJson(),
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequestModel signupRequestModel,
  }) async {
    return await dioClient.request(
      path: ApiService.signup,
      method: RequestMethode.POST.name,
      data: signupRequestModel.toJson(),
    );
  }
}
