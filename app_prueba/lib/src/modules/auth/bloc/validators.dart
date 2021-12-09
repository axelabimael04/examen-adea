import 'dart:async';

class ValidatorsAuth {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email)){
        sink.add(email);
      }
      else {
        sink.addError('Correo inválido');
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length>7){
        sink.add(password);
      } else {
        sink.addError('8 caracteres o más por favor');
      }
    }
  );
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink){
      if(name.length>0){
        sink.add(name);
      } else {
        sink.addError('Campo requerido');
      }
    }
  );
}