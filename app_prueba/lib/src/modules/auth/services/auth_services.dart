import 'package:app_prueba/src/modules/auth/widgets/dialogs.dart';
import 'package:app_prueba/src/modules/navigation/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthProviders {
  Future<void> signOutFirebase() async {
    await FirebaseAuth.instance.signOut();
  }

  void firebaseAuthExceptionsWithDialogs(BuildContext context, {FirebaseException e,}) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        Navigator.pop(context);
        alertWithIcon(
            context,
            title: "Usuario registrado con otro proveedor",
            message: "Tu cuenta esta registrada con otro método de inicio de sesión",
            icon: Icons.person);
        break;
      case 'invalid-credential':
        Navigator.pop(context);
        alertWithIcon(
            context,
            title: "Error en la verificación de la cuenta",
            message: "Intenta con otro método de incio de sesión",
            icon: Icons.person);
        break;
      case 'operation-not-allowed':
      Navigator.pop(context);
        alertWithIcon(
            context,
            title: "Sin permisos",
            message: "Operación no permitida",
            icon: Icons.person);
        break;

      case 'user-disabled':
        Navigator.pop(context);
        alertWithIcon(
            context,
            title: "Sin acceso",
            message: "ACCESO NO AUTORIZADO.\nContacte al administrador",
            icon: Icons.person);
        break;

      case 'user-not-found':
        Navigator.pop(context);
        alertWithIcon(
            context,
            title: "No registrado",
            message: "Correo no registrado. Registre una cuenta.",
            icon: Icons.person_add_disabled_rounded);
        break;

      case 'wrong-password':
        Navigator.pop(context);
        alertWithIcon(
            context,
            title: "Ocurrió un error",
            message: "Correo y/o contraseña incorrectos",
            icon: Icons.report_outlined);
        break;

      case 'email-already-in-use':
        Navigator.pop(context);
        alertWithIcon(
            context,
            title: "Correo en uso",
            message: "El correo a registrar ya esta en uso, intente otro.",
            icon: Icons.error_outline_rounded);
        break;
      case 'invalid-verification-code':
      Navigator.pop(context);
        alertWithIcon(
            context,
            title: "Código de verificación incorrecto",
            message: "Solicita un nuevo código de verificación",
            icon: Icons.person);
        break;

      case 'invalid-verification-id':
      Navigator.pop(context);
        alertWithIcon(
            context,
            title: "ID de verificación incorrecto",
            message: "No se pudo verificar el numero de teléfono",
            icon: Icons.person);
        break;

      default:
        Navigator.pop(context);
        informationAlert(
            context,
            message: e.code,
            title: "Información");

        break;
    }
  }
}

class UserData {
  Future<void> createUserDataOnDataBase(
      {@required String userUID,
      @required String fullName,
      @required email}) async {
    await FirebaseFirestore.instance.collection("users").doc(userUID).set({
        "created": Timestamp.now(),
        "email": email,
        "enabled": true,
        "full_name": fullName,
        "photoUrl":"",
        "rfc": "",
        'age': ''
      
    });
  }
}

class ProcessForAuthenticatedUser {
  final UserCredential firebaseUser;
  final String email;
  final String fullName;

  ProcessForAuthenticatedUser(
      {@required this.firebaseUser,
      @required this.fullName,
      @required this.email});

  Future<void> processForEmailAndPassword(BuildContext context, {@required bool forLogin}) async {
    if (forLogin) {
      await UserData().createUserDataOnDataBase(userUID: firebaseUser.user.uid, email: email, fullName: fullName);
    } 
    await _onSuccessLogin(context);
  }

  Future<void> _onSuccessLogin(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_) => HomePage(
        )), (route) => false);
  }
}
