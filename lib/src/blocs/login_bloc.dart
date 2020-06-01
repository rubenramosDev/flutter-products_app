import 'dart:async';

import 'package:productsapp/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

/*Mixing*/
class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  /*Adding stream values*/
  Function(String) get onChangeEmail => _emailController.sink.add;

  Function(String) get onChangePassword => _passwordController.sink.add;

  /*Listening stream values*/
  Stream<String> get emailStream => _emailController.stream;

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidStream => CombineLatestStream.combine2(
      emailStream, passwordStream, (emailStream, passwordStream) => true);

  /*Last values*/
  String get valueEmail     => _emailController.value;
  String get valuePassword  =>  _passwordController.value;

  /*To finish both stream controllers. We validate with ?, if is not open, donsent execute the code*/
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
