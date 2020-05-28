import 'dart:async';

class Validators {
  //Recibimos un string y sale un string
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    /*If password length > 6, its a valid string*/
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('6 value password is nedeed');
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern = 'Regular expression';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Invalid email');
    }
  });
}
