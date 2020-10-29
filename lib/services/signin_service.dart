import 'package:flutter/material.dart';

class SignInService {
  static final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
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

  void onSignIn() {
    if (!signInFormKey.currentState.validate()) {
      return;
    }
    signInFormKey.currentState.save();
  }

  void onAnonSignIn() {
    print("Anonymouse user");
  }
}
