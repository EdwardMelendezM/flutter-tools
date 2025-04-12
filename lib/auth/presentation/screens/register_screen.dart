import 'package:flutter/material.dart';
import 'package:testapp/auth/presentation/components/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body: const SingleChildScrollView(
        child: RegistrationForm(),
      ),
    );
  }
}
