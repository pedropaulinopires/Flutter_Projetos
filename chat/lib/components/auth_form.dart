import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthFormData _authFormData = AuthFormData();
  final _formKey = GlobalKey<FormState>();

  void submit() {
    final valid = _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authFormData.isSignup)
                TextFormField(
                  decoration: InputDecoration(label: Text('Nome')),
                  key: ValueKey('name'),
                  initialValue: _authFormData.name,
                  onChanged: (value) => _authFormData.name = value,
                ),
              TextFormField(
                decoration: InputDecoration(label: Text('Email')),
                key: ValueKey('email'),
                initialValue: _authFormData.email,
                onChanged: (value) => _authFormData.email = value,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Senha')),
                key: ValueKey('password'),
                initialValue: _authFormData.password,
                onChanged: (value) => _authFormData.password = value,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: submit,
                child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authFormData.toggleMode();
                  });
                },
                child: Text(_authFormData.isLogin
                    ? 'Criar uma nova conta?'
                    : 'Já possui uma conta?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
