import 'package:productsapp/src/model/Product.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:productsapp/src/preferences/preferencias_usuario.dart';

class ProductService {
  final String _url = 'https://flutter-lambda.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json?auth=${_prefs.token}';

    final response = await http.post(url, body: productModelToJson(product));
    final decodeData = jsonDecode(response.body);
    print(decodeData);

    return true;
  }

  Future<bool> updateProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json?auth=${_prefs.token}';

    final response = await http.put(url, body: productModelToJson(product));
    final decodeData = jsonDecode(response.body);
    print(decodeData);

    return true;
  }

  Future<List<ProductModel>> getAllProducts() async {
    final url = '$_url/products.json?auth=${_prefs.token}';

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
    final url = '$_url/products/$id.json?auth=${_prefs.token}';
    final response = await http.delete(url);
    print(json.decode(response.body));
    return 1;
  }

  Future<String> uploadImage(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dpysjwg7e/image/upload?upload_preset=xofchc8x');
    final mimeType = mime(imagen.path).split('/');

    final imageRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageRequest.files.add(file);
    final requestResponse = await imageRequest.send();

    final response = await http.Response.fromStream(requestResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Error ${response.body}');
      return null;
    }

    final responseData = json.decode(response.body);
    return responseData['secure_url'];
  }
}
