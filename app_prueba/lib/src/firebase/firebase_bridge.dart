
import 'dart:io';

import 'package:app_prueba/src/modules/auth/auth_provider.dart';
import 'package:app_prueba/src/modules/auth/widgets/dialogs.dart';
import 'package:app_prueba/src/modules/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FirebaseBridge{

  Future updateUserPhoto(BuildContext context, ) async {
    ImagePicker _picker = ImagePicker();
    XFile image = await _picker.pickImage(source: ImageSource.camera);
    File fileImage = File(image.path);
    progressIndicatorForAuth(context: context, message: 'Actualizando');
    TaskSnapshot uploadTask = await FirebaseStorage.instance.ref()
    .child('${Provider.of<AuthProvider>(context, listen: false).userUID}/${image.path}')
    .putFile(fileImage);
    String imageUrl = await uploadTask.ref.getDownloadURL();

    await FirebaseFirestore.instance
    .collection('users')
    .doc(Provider.of<AuthProvider>(context, listen: false).userUID)
    .update({
      'photoUrl': imageUrl
    });

    Navigator.pop(context);
}

  Future updateUserData(BuildContext context, UserModel user) async{
    progressIndicatorForAuth(context: context, message: 'Actualizando');
     await FirebaseFirestore.instance
    .collection('users')
    .doc(Provider.of<AuthProvider>(context, listen: false).userUID)
    .update({
      'full_name': user.fullName,
      'age': user.age,
      'rfc': user.rfc
    });
    Navigator.pop(context);
    Navigator.pop(context);
  }
}