import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String,
        name: json['name'] as String,
        price: (json['price'] as num).toDouble(),
      );
}

class ProductRepository {
  final Dio _dio;
  ProductRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<Product>> fetchProducts() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'jwt_token');
    final response = await _dio.get(
      'http://localhost:3000/api/products',
      options: Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : {},
      ),
    );
    if (response.statusCode == 200) {
      final List data = response.data['data'] as List;
      return data
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Erro ao buscar produtos');
  }
}
