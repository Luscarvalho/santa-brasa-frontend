import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:santa_brasa/feature/home/home_controller.dart';
import 'package:santa_brasa/routing/routes.dart';
import 'package:santa_brasa/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  final HomeController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final controller = widget.controller;

  @override
  void initState() {
    super.initState();
    controller.loadUser();
  }

  void goToLogin() {
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ValueListenableBuilder(
        valueListenable: controller.user,
        builder: (BuildContext context, user, Widget? child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user?.name ?? ""),
              Text(user?.role.name ?? ""),
              if (user?.role == UserRole.colaborador)
                ElevatedButton(
                  onPressed: () {
                    context.push(Routes.product);
                  },
                  child: const Text('Produtos'),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.push(Routes.product);
                },
                child: const Text('Produtos'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  await controller.logout();
                  goToLogin();
                },
                child: const Text('Logout'),
              ),
            ],
          );
        },
      ),
    );
  }
}
