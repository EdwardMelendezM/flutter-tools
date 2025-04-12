import 'package:testapp/auth/domain/auth_entity.dart';

abstract class AuthUseCase {
  Future<Response<LoginResponse>> login(LoginBody loginEntity);
}
