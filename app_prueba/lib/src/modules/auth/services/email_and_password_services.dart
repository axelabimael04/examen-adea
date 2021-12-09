import 'package:app_prueba/src/modules/auth/auth_provider.dart';
import 'package:app_prueba/src/modules/auth/services/auth_services.dart';
import 'package:app_prueba/src/modules/auth/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _UserAuthWithEmailAndPassword {
  
  Future<UserCredential> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      {@required String email, @required String password}) async {
    UserCredential _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _user;
  }
}

class EmailAndPasswordAuth {

  final BuildContext context;
  EmailAndPasswordAuth({@required this.context});

    Future<void> userLoginWithEmailAndPassword(
      {@required String email,
      @required String password}) async {

    progressIndicatorForAuth(context: context, message: 'Iniciando sesión');
    
    try {
      UserCredential _userFirebase = await _UserAuthWithEmailAndPassword().signInWithEmailAndPassword(
          email: email, password: password);

      String tokenID = await _userFirebase.user.getIdToken();

      Provider.of<AuthProvider>(context, listen: false).userUID = _userFirebase.user.uid;
      Provider.of<AuthProvider>(context, listen: false).authTokenID = tokenID;


      await ProcessForAuthenticatedUser(firebaseUser: _userFirebase, email: null, fullName: null).processForEmailAndPassword(context, forLogin: false);

    } on FirebaseAuthException catch (e) {
      UserAuthProviders().firebaseAuthExceptionsWithDialogs(context, e: e, );
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {@required BuildContext context, @required String email, @required String password, @required String fullName}) async {

    progressIndicatorForAuth(context: context, message: 'Registrando');

    try {
      UserCredential _userFirebase = await _UserAuthWithEmailAndPassword().createUserWithEmailAndPassword(
          email: email, password: password);

      String tokenID = await _userFirebase.user.getIdToken();

      Provider.of<AuthProvider>(context, listen: false).userUID = _userFirebase.user.uid;
      Provider.of<AuthProvider>(context, listen: false).authTokenID = tokenID;

      await ProcessForAuthenticatedUser(firebaseUser: _userFirebase,
      email: email,
      fullName: fullName
      ).processForEmailAndPassword(context, forLogin: true);

    } on FirebaseAuthException catch (e) {
      UserAuthProviders().firebaseAuthExceptionsWithDialogs(context, e: e,);
    }
  }
}
