String? emailValid(email) {
  final validEmail = RegExp('[\\w]+@[\\w]+.[\\w]+');
  if (validEmail.hasMatch(email)) return null;
  return '"$email" não é um e-mail válido!';
}

String? nameValid(name) {
  final validname = RegExp('\\w+ \\w*');
  if (validname.hasMatch(name)) return null;
  return 'Nome "$name" inválido, necessário o nome completo!';
}

String? passwordValid(password) {
  final validPassword = RegExp('^.{6,}\$');
  if (validPassword.hasMatch(password)) return null;
  return 'Sua senha deve ter no mínimo 6 caracteres';
}
