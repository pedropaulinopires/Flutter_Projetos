import 'package:chat/components/auth_form.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoding = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => isLoding = true);

      if (formData.isLogin) {
        // login
        await AuthService().login(
          formData.email,
          formData.password,
        );
      } else {
        // signup
        await AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (error) {
      return;
    } finally {
      setState(() => isLoding = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: AuthForm(
                  onSubmit: _handleSubmit,
                ),
              ),
            ),
            if (isLoding)
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(58, 0, 0, 0),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ));
  }
}
