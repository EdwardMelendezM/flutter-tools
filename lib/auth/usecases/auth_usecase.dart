import 'package:testapp/auth/domain/auth_entity.dart';
import 'package:testapp/auth/domain/auth_repository.dart';
import 'package:testapp/auth/domain/auth_usecase.dart';

class AuthUseCaseImp implements AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCaseImp(this._authRepository);

  @override
  Future<Response<LoginResponse>> login(LoginBody loginEntity) async {
    await Future.delayed(
        Duration(seconds: 2)); // Agrega un tiempo de espera de 2 segundos
    print('Login UseCase: ${loginEntity.email} ${loginEntity.password}');
    var response = await _authRepository.login(loginEntity);
    if (response != null) {
      return Response<LoginResponse>(data: response, error: null);
    } else {
      return Response<LoginResponse>(error: 'Login failed');
    }
  }
}
