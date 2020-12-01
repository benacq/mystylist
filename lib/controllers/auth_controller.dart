import 'dart:async';
import 'package:my_stylist/screens/customers/customer_navigation.dart';
import 'package:my_stylist/screens/onboarding/onboarding.dart';
import 'package:my_stylist/screens/stylist/home/stylist_home.dart';
import '../utils/message_consts.dart' as Constants;
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
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  Rx<User> _firebaseUser = Rx<User>();
  String _email;
  String _password;
  bool _isPasswordMasked = true;
  bool _isLoading = false;

  String get email => _email;
  String get pass => _password;
  bool get isPasswordMasked => _isPasswordMasked;
  bool get isLoading => _isLoading;

  User get user => _firebaseUser?.value;

  static final errorSnackBar = ({String title, String message}) => Get.snackbar(
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

  Future<dynamic> isOnboardingComplete(String uid) async {
    return userCollection.doc(uid).get().then((document) {
      if (document.data().containsKey("account_type")) {
        return document.get("account_type");
      } else {
        return false;
      }
    });
  }

  void onSignIn() async {
    if (!signInFormKey.currentState.validate()) {
      return;
    }
    signInFormKey.currentState.save();
    try {
      _isLoading = true;
      update();
      await _firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((userData) async {
        // Check if user has filled onboarding already before redirecting
        await AuthController()
            .isOnboardingComplete(userData.user.uid)
            .then((status) {
          _isLoading = false;
          update();
          if (status == Constants.USER_ACCOUNT_BUSINESS) {
            Get.offAll(StylistHome());
          } else if (status == Constants.USER_ACCOUNT_CUSTOMER) {
            Get.offAll(CustomerNavigation());
          } else {
            Get.offAll(OnboardingScreen());
          }
        }).catchError((error) {
          _isLoading = false;
          update();
          errorSnackBar(
              title: "Error",
              message: "Something went wrong, please try again later");
        });
      }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
    } on TimeoutException catch (e) {
      print("::::: ${e.message} ");
      errorSnackBar(
          title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MESSAGE);
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      update();
      print("${e.code} ::::: ${e.message} ");
      switch (e.code) {
        case "user-not-found":
          errorSnackBar(
              title: "USER NOT FOUND",
              message: Constants.USER_NOT_FOUND_MESSAGE);
          break;

        case "wrong-password":
          errorSnackBar(
              title: "INCORRECT CREDENTIALS",
              message: Constants.WRONG_CREDENTIALS_MESSAGE);
          break;

        case "too-many-requests":
          errorSnackBar(
              title: Constants.TOO_MANY_REQUESTS_TITLE,
              message: Constants.TOO_MANY_REQUESTS_MESSAGE);
          break;

        case "unknown":
          errorSnackBar(
              title: Constants.NO_CONNECTION_TITLE,
              message: Constants.NO_CONNECTION_MESSAGE);
          break;

        default:
          errorSnackBar(title: "ERROR", message: e.message);
      }
    }
  }

  void onSignUp() async {
    if (!signUpFormKey.currentState.validate()) {
      return;
    }
    signUpFormKey.currentState.save();
    try {
      _isLoading = true;
      update();
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((newUser) {
        userCollection
            .doc(newUser.user.uid)
            .set({"email": _email}).whenComplete(() =>
                {_isLoading = false, update(), Get.offAll(OnboardingScreen())});
      }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
    } on TimeoutException catch (_) {
      errorSnackBar(
          title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MESSAGE);
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      update();
      print("${e.code} ::::: ${e.message} ");

      switch (e.code) {
        case "unknown":
          errorSnackBar(
              title: Constants.NO_CONNECTION_TITLE,
              message: Constants.NO_CONNECTION_MESSAGE);
          break;

        case "too-many-requests":
          errorSnackBar(
              title: Constants.TOO_MANY_REQUESTS_TITLE,
              message: Constants.TOO_MANY_REQUESTS_MESSAGE);
          break;

        default:
          errorSnackBar(title: "ERROR", message: e.message);
      }
    }
  }

  void onSignInAnon() {
    print("Anonymous user");
  }

  static void signOut() {
    _firebaseAuth.signOut().then((value) => Get.offAll(SignIn()));
  }
}
