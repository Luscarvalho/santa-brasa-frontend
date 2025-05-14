import 'dart:developer';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../env.dart';
import '../models/user_model.dart';

class LoginRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  LoginRepository({Dio? dio, FlutterSecureStorage? storage})
      : _dio = dio ?? Dio(),
        _storage = storage ?? const FlutterSecureStorage();

  Future<UserModel?> login(String email, String senha) async {
    try {
      final response = await _dio.post(
        '${Env.apiBaseUrl}/auth/login',
        data: {'email': email, 'password': senha},
      );
      if (response.statusCode == 200 && response.data['token'] != null) {
        final token = response.data['token'];
        await _storage.write(key: 'jwt_token', value: token);
        final userResponse = await _dio.get(
          '${Env.apiBaseUrl}/users/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        final user = UserModel.fromJson(userResponse.data['data']);
        await _storage.write(
            key: 'user_data', value: jsonEncode(user.toJson()));
        return user;
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Status code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      log('DioError during login: ${e.message}');
      throw Exception('Erro ao fazer login: ${e.message}');
    } catch (e) {
      log('Unexpected error during login: $e');
      throw Exception('Erro inesperado ao fazer login');
    }
  }

  Future<UserModel?> getSavedUser() async {
    final userData = await _storage.read(key: 'user_data');
    if (userData == null) return null;
    try {
      final Map<String, dynamic> json = jsonDecode(userData);
      return UserModel.fromJson(json);
    } catch (e) {
      log('Erro ao recuperar usuário salvo: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    await _storage.delete(key: 'user_data');
  }

  Future<bool> valideToken() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) return false;
    try {
      final userResponse = await _dio.get(
        '${Env.apiBaseUrl}/users/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (userResponse.statusCode == 200 && userResponse.data['data'] != null) {
        final user = UserModel.fromJson(userResponse.data['data']);
        await _storage.write(
            key: 'user_data', value: jsonEncode(user.toJson()));
        return true;
      }
      return false;
    } on DioException catch (e) {
      log('DioError during token validation: ${e.message}');
      return false;
    } catch (e) {
      log('Unexpected error during token validation: $e');
      return false;
    }
  }
}
