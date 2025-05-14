import 'package:flutter/material.dart';
import 'package:santa_brasa/data/product_repository.dart';

class ProductController {
  final ProductRepository _repository;
  final ValueNotifier<List<Product>> products = ValueNotifier([]);
  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);

  ProductController({required ProductRepository repository})
      : _repository = repository;

  Future<void> fetchProducts() async {
    loading.value = true;
    error.value = null;
    try {
      products.value = await _repository.fetchProducts();
    } catch (e) {
      error.value = 'Erro ao buscar produtos';
    } finally {
      loading.value = false;
    }
  }
}
