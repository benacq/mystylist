import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_stylist/services/onboarding_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/message_consts.dart' as Constants;

class OnboardingController extends GetxController {
  static GlobalKey<FormState> pv1FormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> pv2FormKey = GlobalKey<FormState>();

  OnboardingService onboardingService = new OnboardingService();

  static PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  bool _isLoading = false;
  SharedPreferences _prefs;

  String _userFullName;
  String _accountType = "I am a Customer";

  //if user is a customer
  String _customerContact;
  String _customerLocation;

  //if user is a beautician
  String _businessName;
  String _businessContact;
  String _businessLocation;
  String _region;

  // getters
  SharedPreferences get preferences => _prefs;
  bool get isLoading => _isLoading;

  int get currentPage => _currentPage;
  String get userFullName => _userFullName;
  String get accountType => _accountType;

  String get customerContact => _customerContact;
  String get customerLocation => _customerLocation;

  String get businessName => _businessName;
  String get businessContact => _businessContact;
  String get businessLocation => _businessLocation;
  String get region => _region;

  set setCurrentPage(int page) {
    if (page != null) {
      _currentPage = page;
      update();
    }
  }

  set setFullName(String fullName) {
    if (fullName != null) {
      _userFullName = fullName;
    }
    return;
  }

  set setAccountType(String account) {
    if (account != null) {
      _accountType = account;
    }
    return;
  }

  set setRegion(String selectedRegion) {
    if (selectedRegion != null) {
      _region = selectedRegion;
    }
    return;
  }

  set setCustomerContact(String contact) {
    if (contact != null) {
      _customerContact = contact;
    }
    return;
  }

  set setCustomerLocation(String location) {
    if (location != null) {
      _customerLocation = location;
    }
    return;
  }

  set setBusinessName(String businessName) {
    if (businessName != null) {
      _businessName = businessName;
    }
    return;
  }

  set setBusinessContact(String businessContact) {
    if (businessContact != null) {
      _businessContact = businessContact;
    }
    return;
  }

  set setBusinessLocation(String businessLocation) {
    if (businessLocation != null) {
      _businessLocation = businessLocation;
    }
    return;
  }

  set setIsLoading(bool loadStatus) {
    _isLoading = loadStatus;
    return;
  }

  // void setPreferenceValues() {
  //   if (_prefs != null) {
  //     switch (_currentPage) {
  //       case 0:
  //         _userFullName = _prefs.getString(Constants.PREF_KEY_FULLNAME);
  //         break;
  //       case 1:
  //         _accountType = _prefs.getString(Constants.PREF_KEY_ACC_TYPE);
  //         break;
  //       case 2:
  //         pv2FormKey.currentState.reset();
  //         if (_accountType == "I am a Customer") {
  //           _customerContact =
  //               _prefs.getString(Constants.PREF_KEY_CUST_CONTACT);
  //           _customerLocation =
  //               _prefs.getString(Constants.PREF_KEY_CUST_LOCATION);
  //         } else if (_accountType == "I am a Beautician") {
  //           _businessName = _prefs.getString(Constants.PREF_KEY_BUSS_NAME);
  //           _businessContact =
  //               _prefs.getString(Constants.PREF_KEY_BUSS_CONTACT);
  //           _businessLocation =
  //               _prefs.getString(Constants.PREF_KEY_BUSS_LOCATION);
  //         }
  //         break;
  //     }
  //   }
  // }

  void removePreferences() {
    if (_prefs != null) {
      _prefs.clear();
    }
  }

  void validatePageViewFirstPage() {
    if (pv1FormKey.currentState.validate()) {
      pv1FormKey.currentState.save();

      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void validatePageViewLastPage() {
    if (pv2FormKey.currentState.validate()) {
      pv2FormKey.currentState.save();
      _isLoading = true;
      update();
      if (accountType == "I am a Beautician") {
        onboardingService.createBusiness();
      } else {
        onboardingService.createCustomer();
      }
    }
  }
}
