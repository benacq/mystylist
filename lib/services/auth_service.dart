import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  String email;
  String password;
  AuthService({this.email, this.password});

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

  Future<bool> changeEmail(newEmail) async {
    return _firebaseAuth.currentUser.updateEmail(newEmail).then((value) {
      messageSnackbar(
          title: "Email updated",
          message: "Your email has been changed",
          colorText: Color.fromRGBO(66, 201, 152, 1));
      return true;
    }).catchError((error) {
      switch (error?.code) {
        case "invalid-email":
          messageSnackbar(
              title: "Invalid email", message: "This email is invalid");
          break;
        case "email-already-in-use":
          messageSnackbar(
              title: "Email exist", message: "This email is already in use");
          break;
        case "requires-recent-login":
          messageSnackbar(
              title: "Requires recent Login",
              duration: Duration(seconds: 5),
              message:
                  "Operation requires recent login, please Logout and Log back in to proceed");
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
        case "weak-password":
          messageSnackbar(
              title: "Password too weak",
              message: "Please enter a stronger password");
          break;
        case "requires-recent-login":
          messageSnackbar(
              title: "Requires recent Login",
              duration: Duration(seconds: 5),
              message:
                  "Operation requires recent login, please Login to proceed");
          Future.delayed(
              new Duration(seconds: 8), () => {_firebaseAuth.signOut()});
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
