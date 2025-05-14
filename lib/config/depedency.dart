import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:santa_brasa/data/login_repository.dart';
import 'package:santa_brasa/data/product_repository.dart';
import 'package:santa_brasa/feature/home/home_controller.dart';
import 'package:santa_brasa/feature/login/login_controller.dart';
import 'package:santa_brasa/feature/product/product_controller.dart';

final getIt = GetIt.instance;

void setupInjection() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepository(
      dio: getIt(),
      storage: getIt(),
    ),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(
      dio: getIt(),
    ),
  );
  getIt.registerFactory<LoginController>(
    () => LoginController(
      repository: getIt(),
    ),
  );
  getIt.registerFactory<HomeController>(
    () => HomeController(
      repository: getIt(),
    ),
  );
  getIt.registerFactory<ProductController>(
    () => ProductController(
      repository: getIt(),
    ),
  );
}
