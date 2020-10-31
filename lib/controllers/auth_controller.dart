import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  static final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>();
  String _email;
  String _password;

  String get email => _email;
  String get pass => _password;

  String get user => _firebaseUser?.value?.uid;

  @override
  void onInit() {
    _firebaseUser.bindStream(_firebaseAuth.authStateChanges());
    super.onInit();
  }

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

  void onSignIn() async {
    if (!signInFormKey.currentState.validate()) {
      return;
    }
    signInFormKey.currentState.save();
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) => print("Signin success"));
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error signing in", e.message,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void onSignUp() async {
    if (!signUpFormKey.currentState.validate()) {
      return;
    }
    signUpFormKey.currentState.save();
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) => print("Signin success"));
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error signing up", e.message,
          snackPosition: SnackPosition.BOTTOM);
      print(e.message);
    }
  }

  void onSignInAnon() {
    print("Anonymouse user");
  }

  void signOut() {
    _firebaseAuth.signOut();
  }
}
