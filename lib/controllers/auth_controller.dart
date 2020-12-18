import 'dart:async';
import 'package:my_stylist/screens/landing/landing.dart';
import 'package:my_stylist/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:my_stylist/screens/signin/sign_in.dart';

class AuthController extends GetxController {
  static final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  AuthService _authService = new AuthService();

  Rx<User> _firebaseUser = Rx<User>();
  String _email;
  String _password;
  bool _isPasswordMasked = true;
  bool _isLoading = false;

  String get email => _email;
  String get password => _password;
  bool get isPasswordMasked => _isPasswordMasked;
  bool get isLoading => _isLoading;
  User get user => _firebaseUser?.value;
  AuthService get getService => _authService;

  @override
  void onInit() {
    _firebaseUser.bindStream(firebaseAuth.authStateChanges());
    super.onInit();
  }

  void togglePasswordMask() {
    _isPasswordMasked = !_isPasswordMasked;
    update();
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

  set setIsLoading(bool loadStatus) {
    _isLoading = loadStatus;
  }

  Future<dynamic> isOnboardingComplete() async {
    return userCollection
        .doc(firebaseAuth.currentUser.uid)
        .get()
        .then((document) {
      if (document.data().containsKey("account_type")) {
        return document.get("account_type");
      } else {
        return false;
      }
    });
  }

  void onSignUp() {
    if (!signUpFormKey.currentState.validate()) {
      return;
    }
    signUpFormKey.currentState.save();
    _isLoading = true;
    update();
    _authService.signUp(email: _email, password: _password);
  }

  void onSignIn() {
    if (!signInFormKey.currentState.validate()) {
      return;
    }
    signInFormKey.currentState.save();
    _isLoading = true;
    update();
    _authService.signIn(email: _email, password: _password);
  }

  Future<bool> changeEmail(newEmail) async {
    return _authService.changeEmail(newEmail);
  }

  Future changePassword(newPassword) async {
    return _authService.changePassword(newPassword);
  }

  void onSignInAnon() {
    print("Anonymous user");
  }

  static void signOut() {
    firebaseAuth.signOut().then((value) => Get.offAll(Landing()));
  }
}
