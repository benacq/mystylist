import 'package:flutter/material.dart';

class SignUpService {
  static final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  String _email;
  String _password;

  String get email => _email;
  String get pass => _password;

  set setEmail(String email) {
    if (email != null) {
      _email = email;
    }
  }

  set setPassword(String password) {
    if (password != null) {
      _password = password;
    }
  }

  void onSignUp() {
    if (!signUpFormKey.currentState.validate()) {
      return;
    }
    signUpFormKey.currentState.save();
  }
}
