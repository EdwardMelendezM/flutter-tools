import 'package:flutter/material.dart';
import '../components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: const SingleChildScrollView(
        child: LoginForm(),
      ),
    );
  }
}
