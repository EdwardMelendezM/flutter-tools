import 'package:flutter/material.dart';
import 'package:testapp/auth/presentation/screens/register_screen.dart';
import '../screens/login_screen.dart';

class AuthRoutes {
  static const String login = '/';
  static const String register = '/register';
  // Agrega más rutas conforme la aplicación crezca

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
    };
  }
}
