import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String age;
  Timestamp created;
  String email;
  bool enabled;
  String fullName;
  String photoUrl;
  String rfc;
  String userUID;

  UserModel({
    this.age,
    this.created,
    this.email,
    this.enabled,
    this.fullName,
    this.photoUrl,
    this.rfc,
    this.userUID
  });

  factory UserModel.fromJson(DocumentSnapshot user) => UserModel(
    age: user['age'],
    created: user['created'],
    email: user['email'],
    enabled: user['enabled'],
    fullName: user['full_name'],
    photoUrl: user['photoUrl'],
    rfc: user['rfc'],
    userUID: user.id,
  );

}