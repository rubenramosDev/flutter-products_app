import 'package:flutter/material.dart';



import 'package:productsapp/src/blocs/login_bloc.dart';
import 'package:productsapp/src/blocs/products_bloc.dart';

export 'package:productsapp/src/blocs/login_bloc.dart';
export 'package:productsapp/src/blocs/products_bloc.dart';

/*InheritedWidget helps us to pass values all across the app without being obligated of 
sending the value in each widget. So, we can pass a value from the very top of our widget tree till 
the end without sending trough the value in each widget
https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html
*/

class InheritedWidgetLogicBlocProvider extends InheritedWidget {
  final loginBloc     = new LoginBloc();
  final _productsBloc = new ProductsBloc();

  InheritedWidgetLogicBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<InheritedWidgetLogicBlocProvider>()
        .loginBloc);
  }

  static ProductsBloc productsBloc(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<InheritedWidgetLogicBlocProvider>()
        ._productsBloc);
  }
}
