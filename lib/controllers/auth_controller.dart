import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:my_stylist/screens/customers/home/customer_home.dart';
import 'package:my_stylist/screens/signin/sign_in.dart';

class AuthController extends GetxController {
  static final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  bool _isPasswordMasked = true;
  Rx<User> _firebaseUser = Rx<User>();
  String _email;
  String _password;

  String get email => _email;
  String get pass => _password;
  bool get isPasswordMasked => _isPasswordMasked;

  User get user => _firebaseUser?.value;

  final errorSnackBar = ({String title, String message}) => Get.snackbar(
      title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Color.fromRGBO(252, 35, 79, 1));

  @override
  void onInit() {
    _firebaseUser.bindStream(_firebaseAuth.authStateChanges());
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

  void onSignIn() async {
    if (!signInFormKey.currentState.validate()) {
      return;
    }
    signInFormKey.currentState.save();
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) => Get.offAll(CustomerHome()));
    } on FirebaseAuthException catch (e) {
      print("${e.code} ::::: ${e.message} ");
      switch (e.code) {
        case "user-not-found":
          errorSnackBar(
              title: "USER NOT FOUND",
              message:
                  "This credentials do not match with any user in our records");
          break;
        case "wrong-password":
          errorSnackBar(
              title: "INCORRECT CREDENTIALS",
              message: "Your email or password is incorrect");
          break;
        default:
          errorSnackBar(title: "ERROR", message: e.code);
      }
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
          .then((newUser) {
        userCollection
            .doc(newUser.user.uid)
            .set({"email": _email}).then((value) => Get.offAll(CustomerHome()));
      });
    } on FirebaseAuthException catch (e) {
      print("${e.code} ::::: ${e.message} ");
      errorSnackBar(title: "ERROR", message: e.message);
    }
  }

  void onSignInAnon() {
    print("Anonymouse user");
  }

  static void signOut() {
    _firebaseAuth.signOut().then((value) => Get.offAll(SignIn()));
  }
}
