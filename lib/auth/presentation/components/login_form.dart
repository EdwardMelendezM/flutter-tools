import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/rooms/presentation/routes/room_routes.dart';
import '../viewmodels/login_viewmodel.dart';
import '../routes/app_routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }
    // Se puede agregar validación de formato si se desea.
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    return null;
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final loginVM = Provider.of<LoginViewModel>(context, listen: false);
      // loginVM.login(
      //   context,
      //   _emailController.text.trim(),
      //   _passwordController.text.trim(),
      // );
      //Redirect
      // to the main screen after login
      Navigator.pushReplacementNamed(context, RoomRoutes.rooms);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: _validateEmail,
              enabled: !loginVM.isLoading, // Disable the field when submitting
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: _validatePassword,
              enabled: !loginVM.isLoading,
            ),
            const SizedBox(height: 16),
            if (loginVM.errorMessage != null)
              Text(
                loginVM.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            loginVM.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () => _submit(context),
                    child: const Text("Iniciar Sesión"),
                  ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Redirecciona a la pantalla de registro
                if (!loginVM.isLoading)
                  Navigator.pushNamed(context, AuthRoutes.register);
              },
              child: const Text("¿No tienes una cuenta? Regístrate"),
            ),
          ],
        ),
      ),
    );
  }
}
