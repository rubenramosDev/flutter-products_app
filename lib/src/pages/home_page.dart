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
      body: _fetchingData(context),
      floatingActionButton: _creatingButton(context),
    );
  }

  Widget _creatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }

  Widget _fetchingData(BuildContext context) {
    return FutureBuilder(
      future: productService.getAllProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => _createItem(products[i], context),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(ProductModel product, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        productService.deleteProduct(product.id);
      },
      background: Container(
        color: Colors.red,
      ),
      child: ListTile(
        title: Text('${product.titulo} - ${product.valor}'),
        subtitle: Text('$product.id'),
        onTap: () => Navigator.pushNamed(context, 'product',arguments: product),
      ),
    );
  }
}
