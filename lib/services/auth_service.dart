import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/screens/customers/customer_navigation.dart';
import 'package:my_stylist/screens/onboarding/onboarding.dart';
import 'package:my_stylist/screens/stylist/stylist_navigation.dart';
import '../utils/message_consts.dart' as Constants;

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection("Customers");
  final CollectionReference stylistCollection =
      FirebaseFirestore.instance.collection("Stylists");
  AuthController _authController;

  String email;
  String password;

  static final messageSnackbar = (
          {String title,
          String message,
          Duration duration = const Duration(seconds: 3),
          Color colorText = const Color.fromRGBO(252, 35, 79, 1)}) =>
      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          duration: duration,
          backgroundColor: Colors.white,
          colorText: colorText);

  set setController(AuthController controller) {
    _authController = controller;
  }

  Future<void> signUp({String email, String password}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((newUser) {
        Get.offAll(OnboardingScreen());
        _authController.setIsLoading = false;
        _authController.update();
      }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
    } on TimeoutException catch (_) {
      _authController.setIsLoading = false;
      _authController.update();
      messageSnackbar(
          title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MSG);
    } on FirebaseAuthException catch (e) {
      _authController.setIsLoading = false;
      _authController.update();
      print("${e.code} ::::: ${e.message} ");

      switch (e.code) {
        case Constants.AUTH_UNKNOWN_CODE:
          messageSnackbar(
              title: Constants.AUTH_UNKNOWN_TITLE,
              message: Constants.AUTH_UNKNOWN_MSG);
          break;

        case Constants.AUTH_WEAK_PASSWORD_CODE:
          messageSnackbar(
              title: Constants.AUTH_WEAK_PASSWORD_TITLE,
              message: Constants.AUTH_WEAK_PASSWORD_MSG);
          break;

        case Constants.AUTH_INVALID_EMAIL_CODE:
          messageSnackbar(
              title: Constants.AUTH_INVALID_EMAIL_TITLE,
              message: Constants.AUTH_INVALID_EMAIL_MSG);
          break;

        case Constants.AUTH_EMAIL_IN_USE_CODE:
          messageSnackbar(
              title: Constants.AUTH_EMAIL_IN_USE_TITLE,
              message: Constants.AUTH_EMAIL_IN_USE_MSG);
          break;

        case Constants.MANY_REQUESTS_CODE:
          messageSnackbar(
              title: Constants.MANY_REQUESTS_TITLE,
              message: Constants.MANY_REQUESTS_MSG);
          break;

        default:
          messageSnackbar(title: "Error", message: e.message);
      }
    }
  }

  Future<void> signIn({String email, String password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userData) async {
        // Check if user has filled onboarding already before redirecting
        return await checkOnboardingStatus().catchError((error) {
          _authController.setIsLoading = false;
          _authController.update();
          messageSnackbar(
              title: "Error",
              message: "Something went wrong, please try again later");
        });
      }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
    } on TimeoutException catch (e) {
      print("::::: ${e.message} ");
      messageSnackbar(
          title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MSG);
    } on FirebaseAuthException catch (e) {
      _authController.setIsLoading = false;
      _authController.update();
      print("${e.code} ::::: ${e.message} ");
      switch (e.code) {
        case Constants.AUTH_USER_NOT_FOUND_CODE:
          messageSnackbar(
              title: "USER NOT FOUND",
              message: Constants.AUTH_USER_NOT_FOUND_MSG);
          break;

        case "wrong-password":
          messageSnackbar(
              title: "INCORRECT CREDENTIALS",
              message: Constants.AUTH_WRONG_CREDENTIALS_MSG);
          break;

        case Constants.MANY_REQUESTS_CODE:
          messageSnackbar(
              title: Constants.MANY_REQUESTS_TITLE,
              message: Constants.MANY_REQUESTS_MSG);
          break;

        case Constants.AUTH_UNKNOWN_CODE:
          messageSnackbar(
              title: Constants.AUTH_UNKNOWN_TITLE,
              message: Constants.AUTH_UNKNOWN_MSG);
          break;

        default:
          messageSnackbar(title: "ERROR", message: e.message);
      }
    }
  }

  Future<dynamic> checkOnboardingStatus() async {
    return Future.wait([
      customerCollection.doc(_firebaseAuth.currentUser.uid).get(),
      stylistCollection.doc(_firebaseAuth.currentUser.uid).get()
    ]).then((docs) {
      if (docs[0].exists) {
        // User is a customer
        return Get.offAll(CustomerNavigation());
      } else if (docs[1].exists) {
        // User is a stylist
        return Get.offAll(StylistNavigation());
      } else {
        // onboarding not complete
        return Get.offAll(OnboardingScreen());
      }
    });
  }

  Future<bool> changeEmail(newEmail) async {
    return _firebaseAuth.currentUser.updateEmail(newEmail).then((value) {
      messageSnackbar(
          title: "Email updated",
          message: "Your email has been changed",
          colorText: Color.fromRGBO(66, 201, 152, 1));
      return true;
    }).catchError((error) {
      switch (error?.code) {
        case Constants.AUTH_INVALID_EMAIL_CODE:
          messageSnackbar(
              title: Constants.AUTH_INVALID_EMAIL_TITLE,
              message: Constants.AUTH_INVALID_EMAIL_MSG);
          break;

        case Constants.AUTH_EMAIL_IN_USE_CODE:
          messageSnackbar(
              title: Constants.AUTH_EMAIL_IN_USE_TITLE,
              message: Constants.AUTH_EMAIL_IN_USE_MSG);
          break;

        case Constants.REQUIRE_RECENT_LOGIN_CODE:
          messageSnackbar(
              title: Constants.REQUIRE_RECENT_LOGIN_TITLE,
              duration:
                  Duration(seconds: Constants.REQUIRE_RECENT_LOGIN_DURATION),
              message: Constants.REQUIRE_RECENT_LOGIN_MSG);
          break;

        default:
          messageSnackbar(
              title: "Error",
              message: "Something went wrong, please try again later");
      }
      return false;
    });
  }

  Future changePassword(newPassword) async {
    _firebaseAuth.currentUser
        .updatePassword(newPassword)
        .then((value) => messageSnackbar(
            title: "Password updated",
            message: "Your password has been updated",
            colorText: Color.fromRGBO(66, 201, 152, 1)))
        .catchError((error) {
      switch (error?.code) {
        case Constants.AUTH_WEAK_PASSWORD_CODE:
          messageSnackbar(
              title: Constants.AUTH_WEAK_PASSWORD_TITLE,
              message: Constants.AUTH_WEAK_PASSWORD_MSG);
          break;

        case Constants.REQUIRE_RECENT_LOGIN_CODE:
          messageSnackbar(
              title: Constants.REQUIRE_RECENT_LOGIN_TITLE,
              duration:
                  Duration(seconds: Constants.REQUIRE_RECENT_LOGIN_DURATION),
              message: Constants.REQUIRE_RECENT_LOGIN_MSG);
          break;

        default:
          messageSnackbar(
            title: "Error",
            message: "Something went wrong, please try again later",
          );
      }
    });
  }
}
