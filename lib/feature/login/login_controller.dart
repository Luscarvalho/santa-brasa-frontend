import 'package:flutter/material.dart';
import 'package:santa_brasa/data/login_repository.dart';

class LoginController {
  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);
  final ValueNotifier<bool> loggedIn = ValueNotifier(false);
  final LoginRepository _loginRepository;

  LoginController(this._loginRepository);

  Future<void> login(String email, String senha) async {
    loading.value = true;
    error.value = null;
    try {
      final user = await _loginRepository.login(email, senha);
      loggedIn.value = user != null;
      if (user == null) {
        error.value = 'Login inválido';
      }
    } catch (e) {
      error.value = 'Erro ao fazer login: ${e.toString()}';
    } finally {
      loading.value = false;
    }
  }
}
