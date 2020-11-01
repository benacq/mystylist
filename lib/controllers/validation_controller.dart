import 'dart:core';
import 'package:get/get.dart';

class ValidationService {
  static validateEmail(String email) {
    if (email.isEmpty) {
      return "Enter your email";
    } else if (!GetUtils.isEmail(email)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  static validatePassword(String password) {
    if (password.isEmpty) {
      return "Please enter a password";
    } else if (password.length < 5) {
      return "Password too weak";
    } else {
      return null;
    }
  }
}
