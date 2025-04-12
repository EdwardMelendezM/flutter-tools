import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/auth/infrastructure/rest/auth_repository.dart';
import 'package:testapp/auth/presentation/routes/app_routes.dart';
import 'package:testapp/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:testapp/auth/usecases/auth_usecase.dart';
import 'package:testapp/auth/domain/auth_repository.dart';
import 'package:testapp/auth/domain/auth_usecase.dart';
import 'package:testapp/rooms/presentation/routes/room_routes.dart';

void main() {
  // Instancia del repositorio e inyección del usecase
  final AuthRepository authRepository = AuthRepositoryRest();
  final AuthUseCase authUseCase = AuthUseCaseImp(authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(authUseCase: authUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Combina las rutas de autenticación y rooms
    final Map<String, WidgetBuilder> routes = {
      ...AuthRoutes.routes,
      ...RoomRoutes.routes,
    };

    return MaterialApp(
      title: 'Test App',
      // Define la ruta inicial. Aquí puedes ajustar según tus necesidades.
      initialRoute: '/',
      routes: routes,
    );
  }
}
