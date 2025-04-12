import 'package:testapp/auth/domain/auth_entity.dart';

abstract class AuthRepository {
  Future<LoginResponse?> login(LoginBody loginEntity);
}
