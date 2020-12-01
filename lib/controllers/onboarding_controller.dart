import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:my_stylist/screens/customers/customer_navigation.dart';
import 'package:my_stylist/screens/stylist/stylist_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/message_consts.dart' as Constants;
import 'package:my_stylist/screens/stylist/home/stylist_home.dart';

class OnboardingController extends GetxController {
  static final GlobalKey<FormState> pv1FormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> pv2FormKey = GlobalKey<FormState>();
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");
  User user = FirebaseAuth.instance.currentUser;

  static final PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  static final errorSnackBar = ({String title, String message}) => Get.snackbar(
      title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Color.fromRGBO(252, 35, 79, 1));

  bool _isLoading = false;
  SharedPreferences _prefs;

  String _userFullName;
  String _accountType;

  //if user is a customer
  String _customerContact;
  String _customerLocation;

  //if user is a beautician
  String _businessName;
  String _businessContact;
  String _businessLocation;

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

  Future<SharedPreferences> initialPreference() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  void setPreferenceValues() {
    if (_prefs != null) {
      switch (_currentPage) {
        case 0:
          _userFullName = _prefs.getString(Constants.PREF_KEY_FULLNAME);
          break;
        case 1:
          print("hello");
          _accountType = _prefs.getString(Constants.PREF_KEY_ACC_TYPE);
          break;
        case 2:
          pv2FormKey.currentState.reset();
          if (_accountType == "I am a Customer") {
            _customerContact =
                _prefs.getString(Constants.PREF_KEY_CUST_CONTACT);
            _customerLocation =
                _prefs.getString(Constants.PREF_KEY_CUST_LOCATION);
          } else if (_accountType == "I am a Beautician") {
            _businessName = _prefs.getString(Constants.PREF_KEY_BUSS_NAME);
            _businessContact =
                _prefs.getString(Constants.PREF_KEY_BUSS_CONTACT);
            _businessLocation =
                _prefs.getString(Constants.PREF_KEY_BUSS_LOCATION);
          }
          break;
      }
    }
  }

  void removePreferences() {
    if (_prefs != null) {
      _prefs.clear();
      // DON'T DELETE THESE COMMENTS, I MAY HAVE TO USE IT LATER IF I DECIDE TO USE SHARED PREFERENCES AGAIN
      // _prefs.remove(Constants.PREF_KEY_FULLNAME);
      // _prefs.remove(Constants.PREF_KEY_ACC_TYPE);
      // _prefs.remove(Constants.PREF_KEY_CUST_CONTACT);
      // _prefs.remove(Constants.PREF_KEY_CUST_LOCATION);
      // _prefs.remove(Constants.PREF_KEY_BUSS_NAME);
      // _prefs.remove(Constants.PREF_KEY_BUSS_CONTACT);
      // _prefs.remove(Constants.PREF_KEY_BUSS_LOCATION);
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

      if (accountType == "I am a Beautician") {
        // User is a beautician
        createBusiness().whenComplete(() => removePreferences());
      } else {
        createCustomer().whenComplete(() => removePreferences());
        // User is a customer
      }
    }
  }

  Future<void> createBusiness() async {
    _isLoading = true;
    update();
    try {
      await userCollection.doc(user.uid).update({
        "user_fullname": _userFullName,
        "business_name": _businessName,
        "account_type": "business",
        "contact": _businessContact,
        "location": _businessLocation,
      }).whenComplete(() {
        _isLoading = false;
        update();
        Get.offAll(StylistNavigation());
      }).catchError((error) {
        _isLoading = false;
        update();
        errorSnackBar(
            title: "Error", message: "Something went wrong, please try again");
      }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
    } on TimeoutException catch (_) {
      _isLoading = false;
      update();
      errorSnackBar(
          title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MESSAGE);
    }
  }

  Future<void> createCustomer() async {
    _isLoading = true;
    update();
    try {
      await userCollection.doc(user.uid).update({
        "user_fullname": _userFullName,
        "account_type": "customer",
        "contact": _customerContact,
        "location": _customerLocation,
      }).whenComplete(() {
        _isLoading = false;
        update();
        Get.offAll(CustomerNavigation());
      }).catchError((error) {
        _isLoading = false;
        update();
        errorSnackBar(
            title: "Error", message: "Something went wrong, please try again");
      }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
    } on TimeoutException catch (_) {
      _isLoading = false;
      update();
      errorSnackBar(
          title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MESSAGE);
    }
  }
}
