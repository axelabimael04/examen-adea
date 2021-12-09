import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  String _userUID = '';

  String get userUID => this._userUID;

  set userUID (String value){
    this._userUID = value;
    notifyListeners();
  }

  String _authTokenID = '';

  String get authTokenID => this._authTokenID;

  set authTokenID (String value){
    this._authTokenID = value;
    notifyListeners();
  }
}