import 'package:flutter/material.dart';
import 'package:santa_brasa/data/login_repository.dart';
import 'package:santa_brasa/models/user_model.dart';

class HomeController {
  HomeController({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;

  final ValueNotifier<UserModel?> user = ValueNotifier(null);
  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);

  Future<void> loadUser() async {
    loading.value = true;
    error.value = null;
    try {
      user.value = await _repository.getSavedUser();
    } catch (e) {
      error.value = 'Erro ao carregar usuário: [${e.toString()}';
    } finally {
      loading.value = false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    user.value = null;
  }
}
