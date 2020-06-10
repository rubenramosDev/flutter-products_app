import 'dart:io';

import 'package:productsapp/src/services/product_service.dart';
import 'package:rxdart/rxdart.dart';

import 'package:productsapp/src/model/Product.dart';

class ProductsBloc {
  final _productsService = new ProductService();

  final _productsController = new BehaviorSubject<List<ProductModel>>();
  final _fetchingData = new BehaviorSubject<bool>();

  Stream<List<ProductModel>> get productsStream => _productsController.stream;

  Stream<bool> get fetching => _fetchingData.stream;

  void gettingAllProducts() async {
    final products = await _productsService.getAllProducts();
    _productsController.sink.add(products);
  }

  void creatingProduct(ProductModel product) async {
    _fetchingData.sink.add(true);
    await _productsService.createProduct(product);
    _fetchingData.sink.add(false);
  }

  Future<String> uploadingFile(File file) async {
    _fetchingData.add(true);
    final url = await _productsService.uploadImage(file);
    _fetchingData.sink.add(false);
    return url;
  }

  void updatingProduct(ProductModel product) async {
    _fetchingData.sink.add(true);
    await _productsService.updateProduct(product);
    _fetchingData.sink.add(false);
  }

  void deletingProduct(String id) async {
    _fetchingData.sink.add(true);
    await _productsService.deleteProduct(id);
    _fetchingData.sink.add(false);
  }

  dispose() {
    _productsController?.close();
    _fetchingData?.close();
  }
}
