import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:santa_brasa/routing/routes.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});

  final LoginController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  late final controller = widget.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<bool>(
              valueListenable: controller.loading,
              builder: (context, loading, _) {
                return ElevatedButton(
                  onPressed: loading
                      ? null
                      : () => controller.login(
                            emailController.text,
                            senhaController.text,
                          ),
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text('Entrar'),
                );
              },
            ),
            ValueListenableBuilder<String?>(
              valueListenable: controller.error,
              builder: (context, error, _) {
                if (error == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(error, style: const TextStyle(color: Colors.red)),
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: controller.loggedIn,
              builder: (context, loggedIn, _) {
                if (loggedIn) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    GoRouter.of(context).go(Routes.home);
                  });
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
