import 'package:flutter/material.dart';
import 'package:productsapp/src/blocs/provider.dart';

import 'package:productsapp/src/model/Product.dart';
import 'package:productsapp/src/services/product_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsBloc = InheritedWidgetLogicBlocProvider.productsBloc(context);
    productsBloc.gettingAllProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: _fetchingData(productsBloc, context),
      floatingActionButton: _creatingButton(context),
    );
  }

  Widget _creatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }

  Widget _fetchingData(ProductsBloc productsBloc, BuildContext context) {
    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) =>
                _createItem(productsBloc, products[i], context),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(
      ProductsBloc productsBloc, ProductModel product, BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          productsBloc.deletingProduct(product.id);
        },
        background: Container(
          color: Colors.red,
        ),
        child: Card(
          child: Column(
            children: [
              (product.fotoUrl == null)
                  ? Image(image: AssetImage('assets/img2.png'))
                  : FadeInImage(
                      image: NetworkImage(
                        product.fotoUrl,
                      ),
                      placeholder: AssetImage('assets/img1.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${product.titulo} - ${product.valor}'),
                subtitle: Text('$product.id'),
                onTap: () =>
                    Navigator.pushNamed(context, 'product', arguments: product),
              ),
            ],
          ),
        ));
  }
}
