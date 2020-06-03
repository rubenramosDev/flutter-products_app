import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:productsapp/src/model/Product.dart';
import 'package:productsapp/src/services/product_service.dart';
import 'package:productsapp/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  /*
  * To be able to validate form values before they got
  * send, we have to controlle and get the values of every single input form,
  * so, to get the values, we have to assign a key to every form
  */

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  ProductModel product = new ProductModel();

  final productoService = new ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _creatingName(),
                _creatingPrice(),
                _creatingAvailable(),
                _creatingButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _creatingName() {
    /*To bind the object with the formfield, we use as initialValue
    * the property of the product.*/

    /*onSaved is a method of the field that is executed only when the
    * form filds where validated*/
    return TextFormField(
      initialValue: product.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Product name'),
      validator: (value) {
        if (value.length < 3) {
          return 'Type a valide name';
        } else {
          value = value.trim();
          return null;
        }
      },
      onSaved: (value) => product.titulo = value,
    );
  }

  Widget _creatingPrice() {
    return TextFormField(
      //  initialValue: product.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Price'),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Only numbers';
        }
      },
      onSaved: (value) => product.valor = double.parse(value),
    );
  }

  Widget _creatingButton() {
    return RaisedButton.icon(
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: () => _submit(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple[400],
      textColor: Colors.white,
    );
  }

  void _submit() {
    /*Is not correct*/
    if (!formKey.currentState.validate()) return;

    /*Is correct!*/
    formKey.currentState.save();
    product.titulo = product.titulo.trim();
    productoService.createProduct(product);
  }

  Widget _creatingAvailable() {
    return SwitchListTile(
      value: product.disponible,
      title: Text('Disponible'),
      onChanged: (value) => setState(() {
        product.disponible = value;
      }),
    );
  }
}
