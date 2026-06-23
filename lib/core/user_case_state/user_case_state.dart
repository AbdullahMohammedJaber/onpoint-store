import 'package:ecommerce_one/core/data/remote/auth/auth_data_surce.dart';
import 'package:ecommerce_one/core/domain/repo/auth/auth_repo.dart';
import 'package:ecommerce_one/core/domain/use_case/auth/auth_use_case.dart';
import 'package:ecommerce_one/core/server/dio_helper.dart';

class UserCaseState {
  final authUserCase = AuthUseCase(
    AuthRepoImpl(AuthDataSurceImpl(DioClient())),
  );
}
