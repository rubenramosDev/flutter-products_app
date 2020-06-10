import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productsapp/src/blocs/provider.dart';
import 'package:productsapp/src/model/Product.dart';
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
  /*We create an special key to make reference to the scaffold, in that
  * way the snackbar can show up*/
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  ProductModel product = new ProductModel();
  bool _flag = false;

  /*To save an image or file*/
  PickedFile pickedFile;

  ProductsBloc _productsBloc;

  @override
  Widget build(BuildContext context) {
    /*Before creating the form, we verify if the past page send us a value in the 
    * arguments. If arguments is not null, we must update a product, not create a new one */
    final ProductModel productModel = ModalRoute.of(context).settings.arguments;

    _productsBloc = InheritedWidgetLogicBlocProvider.productsBloc(context);

    if (productModel != null) {
      product = productModel;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () => _processingImage(ImageSource.gallery),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _processingImage(ImageSource.camera),
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
                _showingPhoto(),
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

  /*METHODS*/

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
      initialValue: product.valor.toString(),
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
      onPressed: (_flag) ? null : _submit,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple[400],
      textColor: Colors.white,
    );
  }

  void _submit() async {
    /*Is not correct*/
    if (!formKey.currentState.validate()) return;

    /*Is correct!*/
    formKey.currentState.save();

    setState(() {
      _flag = true;
    });

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      product.fotoUrl = await _productsBloc.uploadingFile(file);
    }

    product.titulo = product.titulo.trim();

    if (product == null) {
      _productsBloc.creatingProduct(product);
    } else {
      _productsBloc.updatingProduct(product);
    }

    _creatingSnackbar('Successfully saved.');
    Navigator.pop(context);
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

  void _creatingSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _showingPhoto() {
    if (product.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(product.fotoUrl),
        placeholder: AssetImage('assets/img1.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      return Image(
        image: AssetImage(pickedFile?.path ?? 'assets/img2.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  void _processingImage(ImageSource origin) async {
    pickedFile = await ImagePicker.platform.pickImage(source: origin);

    if (pickedFile != null) {
      product.fotoUrl = null;
    }

    setState(() {});
  }
}
