import 'package:productsapp/src/model/Product.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String _url = 'https://flutter-lambda.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json';

    final response = await http.post(url, body: productModelToJson(product));
    final decodeData = jsonDecode(response.body);
    print(decodeData);

    return true;
  }

  Future<bool> updateProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json';

    final response = await http.put(url, body: productModelToJson(product));
    final decodeData = jsonDecode(response.body);
    print(decodeData);

    return true;
  }

  Future<List<ProductModel>> getAllProducts() async {
    final url = '$_url/products.json';

    final response = await http.get(url);
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<ProductModel> listProducts = new List();

    if (data == null) return [];

    data.forEach((id, product) {
      final temporalProducto = ProductModel.fromJson(product);
      temporalProducto.id = id;
      listProducts.add(temporalProducto);
    });
    return listProducts;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    final response = await http.delete(url);
    print(json.decode(response.body));
    return 1;
  }
}
