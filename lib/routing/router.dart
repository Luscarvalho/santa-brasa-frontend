import 'package:go_router/go_router.dart';
import 'package:santa_brasa/feature/login/login_screen.dart';
import 'package:santa_brasa/routing/routes.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.loginRelative,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
