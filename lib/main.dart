import 'package:flutter/material.dart';

import 'package:productsapp/src/blocs/provider.dart';
import 'package:productsapp/src/pages/home_page.dart';
import 'package:productsapp/src/pages/login_page.dart';
import 'package:productsapp/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InheritedWidgetLogicBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'product': (BuildContext context) => ProductPage(),
        },
        theme: ThemeData(primarySwatch: Colors.deepPurple),
      ),
    );
  }
}
