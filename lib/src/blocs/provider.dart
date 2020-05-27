import 'package:flutter/material.dart';

import 'login_bloc.dart';
export 'login_bloc.dart';

/*InheritedWidget helps us to pass values all across the app without being obligated of 
sending the value in each widget. So, we can pass a value from the very top of our widget tree till 
the end without sending trough the value in each widget
https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html
*/

class InheritedWidgetLogicBlocProvider extends InheritedWidget {
  final loginBloc = LoginBloc();

  InheritedWidgetLogicBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<InheritedWidgetLogicBlocProvider>()
        .loginBloc);
  }
}
