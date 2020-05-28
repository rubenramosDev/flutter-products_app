import 'dart:async';

import 'package:productsapp/src/blocs/validators.dart';

/*Mixing*/
class LoginBloc with Validators{
  final _emailController    = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();


  /*Adding stream values*/
  Function(String) get onChangeEmail    => _emailController.sink.add;
  Function(String) get onChangePassword => _passwordController.sink.add;

  /*Listening stream values*/
  Stream<String> get emailStream    => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);


  /*To finish both stream controllers. We validate with ?, if is not open, donsent execute the code*/
  dispose(){
   _emailController?.close();
   _passwordController?.close();
  }

}
