import 'package:flutter/material.dart';

import 'package:productsapp/src/blocs/provider.dart';
import 'package:productsapp/src/pages/home_page.dart';
import 'package:productsapp/src/pages/login_page.dart';
import 'package:productsapp/src/pages/product_page.dart';
import 'package:productsapp/src/pages/register_page.dart';
import 'package:productsapp/src/preferences/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

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
          'registro': (BuildContext context) => RegisterPage(),
        },
        theme: ThemeData(primarySwatch: Colors.deepPurple),
      ),
    );
  }
}
