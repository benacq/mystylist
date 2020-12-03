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

  static validatePhone(String phone) {
    if (!GetUtils.isPhoneNumber(phone)) {
      return "Enter a valid phone number";
    } else {
      return null;
    }
  }

  static validateLocation(String location) {
    if (location.isEmpty) {
      return "Please enter your location";
    } else if (location.isNum) {
      return "Please enter a valid location";
    }
    return null;
  }

  static validateserviceName(String serviceName) {
    if (serviceName.isEmpty) {
      return "Please enter a service name";
    }
    return null;
  }

  static validateprice(String price) {
    if (price.isEmpty) {
      return "Please enter a price";
    } else if (!price.isNumericOnly) {
      return 'Price should only be numbers';
    }
    return null;
  }

  static validateduration(String duration) {
    if (duration.isEmpty) {
      return "Please enter a duration";
    } else if (duration.isAlphabetOnly || duration.isNumericOnly) {
      return 'Enter a valid duration time';
    }
    return null;
  }

  static validateexpectedNumber(String expectedNumber) {
    if (expectedNumber.isEmpty) {
      return "Please enter the expected number of customer per day";
    } else if (!expectedNumber.isNumericOnly) {
      return 'Expected number should only be numbers';
    }
    return null;
  }
}
