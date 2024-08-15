class AuthExceptions implements Exception {
  final Map<String, String> msgExceptions = const {
    'INVALID_LOGIN_CREDENTIALS': 'Login/senha inválidos, tente novamente!',
    'EMAIL_EXISTS':'E-mail já em uso por outro usuário!',
    'OPERATION_NOT_ALLOWED':'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Acesso bloqueado temporariamente. Tente novamente mais tarde!',
    'EMAIL_NOT_FOUND':'E-mail não encontrado!',
    'INVALID_PASSWORD':'Senha inválida!',
    'USER_DISABLED': 'A conta do usuário foi desabilitada!',
  };

  final String key;

  const AuthExceptions(this.key);

  @override
  String toString() {
    return msgExceptions[key] ?? 'Ocorreu um erro na autenticação!';
  }
}
