import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth_provider.dart';

enum AuthMode { singup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final Map<String, String> _authData = {'email': '', 'password': ''};
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.login;

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.singup;
  void _swithFormMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.singup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_isLogin()) {
      //LOGIN
      await authProvider.singin(_authData['email']!, _authData['password']!);
    } else {
      //REGISTRAR
      await authProvider.singup(_authData['email']!, _authData['password']!);
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: _isLogin() ? 310 : 400,
          width: deviceSize.width * 0.75,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (email) => _authData['email'] = email,
                  validator: (email) {
                    final emailValue = email ?? '';
                    if (emailValue.trim().length < 5 ||
                        !emailValue.contains("@")) {
                      return 'Digite um email válido!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _passwordController,
                  onChanged: (password) => _authData['password'] = password,
                  validator: (password) {
                    final passwordValue = password ?? '';
                    if (passwordValue.length < 5) {
                      return 'Digite uma senha válida!';
                    }
                    return null;
                  },
                ),
                if (_isSignup())
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Confirmar a senha'),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: _isLogin()
                        ? null
                        : (password) {
                            final passwordValue = password ?? '';

                            if (passwordValue != _passwordController.text) {
                              return 'Senhas informadas não conferem!';
                            }
                            return null;
                          },
                  ),
                const SizedBox(
                  height: 30,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10)),
                    child: Text(
                      _authMode == AuthMode.login ? 'ENTRAR' : 'CADASTRAR',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                const Spacer(),
                TextButton(
                    onPressed: _swithFormMode,
                    child: Text(_isLogin()
                        ? 'DESEJA REGISTRAR?'
                        : 'JÁ POSSUI UMA CONTA?'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
