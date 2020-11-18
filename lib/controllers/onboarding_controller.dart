import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:my_stylist/screens/customers/home/customer_home.dart';
import 'package:my_stylist/screens/onboarding/components/onboarding_progress_indicator.dart';
import 'package:my_stylist/screens/stylist/home/stylist_home.dart';

class OnboardingController extends GetxController {
  static final GlobalKey<FormState> pv1FormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> pv2FormKey = GlobalKey<FormState>();
  // static final GlobalKey<FormState> pv3FormKey = GlobalKey<FormState>();

  static final PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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

  void processFirstPage() {
    if (pv1FormKey.currentState.validate()) {
      pv1FormKey.currentState.save();
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void processLastPage() {
    if (pv2FormKey.currentState.validate()) {
      pv2FormKey.currentState.save();

      if (accountType == "I am a Beautician") {
        // User is a beautician
        createBusiness();
      } else {
        createCustomer();
        // User is a customer
      }
      //Delete shared preference for user fields
      //Set preference for successful onboarding
    }
  }

  void createBusiness() {
    Get.offAll(StylistHome());
  }

  void createCustomer() {
    Get.offAll(CustomerHome());
  }
}
