import 'dart:async';
import 'package:app_prueba/src/modules/auth/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc with ValidatorsAuth{
  
  final _userName = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passwordConfirmController = BehaviorSubject<String>();

  Stream<String> get userNameStream => _userName.stream.transform(validateName);
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);
  Stream<String> get passwordConfirmStream => _passwordConfirmController.stream.transform(validatePassword)
   .doOnData((String c){
     if(0 != _passwordController.value.compareTo(c)){
       _passwordConfirmController.addError('Las contraseñas no coinciden');
     }

   });
  Stream<bool> get formValidStreamLogin => 
    CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  Stream<bool> get formValidStreamSignUp => 
    CombineLatestStream.combine3(userNameStream, emailStream, passwordStream, (u, e, p) => true);

  Function(String) get changeUserName => _userName.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeConfirmPassword => _passwordConfirmController.sink.add;
  

  String get userName => _userName.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get passwordConfirm => _passwordConfirmController.value;



  dispose(){
    _userName.close();
    _emailController.close();
    _passwordController.close();
    _passwordConfirmController.close();
  }
}