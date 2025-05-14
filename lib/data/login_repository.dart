import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../env.dart';
import '../models/user_model.dart';

class LoginRepository {
  Future<UserModel?> login(String email, String senha) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        '${Env.apiBaseUrl}/login',
        data: {'email': email, 'senha': senha},
      );
      if (response.statusCode == 200 && response.data['token'] != null) {
        const storage = FlutterSecureStorage();
        final token = response.data['token'];
        await storage.write(key: 'jwt_token', value: token);
        final userResponse = await dio.get(
          '${Env.apiBaseUrl}/users/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        return UserModel.fromJson(userResponse.data);
      }
      throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Status code: ${response.statusCode}');
    } on DioException catch (e) {
      log('DioError during getProducts: ${e.message}');
      throw Exception('Failed to load products: ${e.message}');
    } catch (e) {
      log('Unexpected error during getProducts: $e');
      throw Exception('Unexpected error while loading products');
    }
  }
}
