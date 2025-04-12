import 'package:testapp/auth/domain/auth_entity.dart';

abstract class AuthUseCase {
  Future<Response> login(LoginBody loginEntity);
}
