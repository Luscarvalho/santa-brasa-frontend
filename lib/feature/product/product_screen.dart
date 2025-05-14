import 'package:flutter/material.dart';
import 'package:santa_brasa/feature/product/product_controller.dart';
import 'package:santa_brasa/data/product_repository.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.controller});
  final ProductController controller;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final controller = widget.controller;

  @override
  void initState() {
    super.initState();
    controller.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: ValueListenableBuilder(
        valueListenable: controller.loading,
        builder: (context, isloading, _) {
          if (isloading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ValueListenableBuilder(
            valueListenable: controller.products,
            builder:
                (BuildContext context, List<Product> products, Widget? child) {
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
