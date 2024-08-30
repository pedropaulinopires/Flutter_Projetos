import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthFormData _authFormData = AuthFormData();
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  void _handleImagePicker(File image) {
    _authFormData.image = image;
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
  }

  void submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    widget.onSubmit(_authFormData);
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
                UserImagePicker(
                  onImagePicker: _handleImagePicker,
                ),
              if (_authFormData.isSignup)
                TextFormField(
                  decoration: const InputDecoration(label: Text('Nome')),
                  key: const ValueKey('name'),
                  initialValue: _authFormData.name,
                  onChanged: (value) => _authFormData.name = value,
                  validator: (value) {
                    final name = value ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres!';
                    }
                    return null;
                  },
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_emailFocus),
                ),
              TextFormField(
                decoration: const InputDecoration(label: Text('E-mail')),
                key: const ValueKey('email'),
                focusNode: _emailFocus,
                initialValue: _authFormData.email,
                onChanged: (value) => _authFormData.email = value,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  final email = value ?? '';
                  if (!email.contains('@')) {
                    return 'O e-mail informado não é valido!';
                  }
                  return null;
                },
                  onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_passwordFocus),
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Senha')),
                key: const ValueKey('password'),
                initialValue: _authFormData.password,
                focusNode: _passwordFocus,
                onChanged: (value) => _authFormData.password = value,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (value) =>  submit(),
                validator: (value) {
                  final password = value ?? '';
                  if (password.length < 6) {
                    return 'A senha deve conter no mínimo 6 caracteres!';
                  }
                  return null;
                },
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
