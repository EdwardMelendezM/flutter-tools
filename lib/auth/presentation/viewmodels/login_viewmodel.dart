import 'package:flutter/material.dart';
import 'package:testapp/auth/domain/auth_entity.dart';
import 'package:testapp/auth/domain/auth_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthUseCase authUseCase;

  bool isLoading = false;
  String? errorMessage;

  LoginViewModel({required this.authUseCase});

  Future<Response<LoginResponse>> login(
      BuildContext context, String email, String password) async {
    // Reinicia el estado
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    // Prepara el objeto LoginBody
    final loginBody = LoginBody(email: email, password: password);

    // Llama al usecase
    final response = await authUseCase.login(loginBody);
    isLoading = false;
    notifyListeners();
    if (response.isSuccess) {
      // Si el login fue exitoso, puedes navegar a otra pantalla o guardar el token.
      // Por ejemplo, podrías emitir un evento o actualizar el estado de la app.
      return response;
    } else {
      // Captura y muestra el error
      errorMessage = response.error;
      return response;
    }
  }
}
