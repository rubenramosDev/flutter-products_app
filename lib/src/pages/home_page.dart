import 'package:flutter/material.dart';
import 'package:productsapp/src/model/Product.dart';
import 'package:productsapp/src/services/product_service.dart';

class HomePage extends StatelessWidget {
  final productService = new ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: _fetchingData(),
      floatingActionButton: _creatingButton(context),
    );
  }

  Widget _creatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }

  Widget _fetchingData() {
    return FutureBuilder(
      future: productService.getAllProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
