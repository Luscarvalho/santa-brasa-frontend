import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:santa_brasa/feature/login/login_screen.dart';
import 'package:santa_brasa/routing/routes.dart';
import 'package:santa_brasa/data/login_repository.dart';
import 'package:santa_brasa/feature/home/home_screen.dart';
import 'package:santa_brasa/feature/product/product_screen.dart';
import 'package:santa_brasa/feature/product/product_controller.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.login,
  redirect: (context, state) async {
    final loginRepository = GetIt.I.get<LoginRepository>();
    final isValid = await loginRepository.valideToken();
    final isLogin = state.uri.path == Routes.login;
    if (!isValid && !isLogin) {
      return Routes.login;
    }
    if (isValid && isLogin) {
      return Routes.home;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => LoginScreen(
        controller: GetIt.I.get(),
      ),
    ),
    GoRoute(
        path: Routes.home,
        builder: (context, state) => HomeScreen(
              controller: GetIt.I.get(),
            ),
        routes: [
          GoRoute(
            path: Routes.productRelative,
            builder: (context, state) => ProductScreen(
              controller: ProductController(
                repository: GetIt.I.get(),
              ),
            ),
          ),
        ]),
  ],
);
