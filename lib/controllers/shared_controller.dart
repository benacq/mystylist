import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:my_stylist/models/customer_model.dart';
import 'package:my_stylist/models/stylist_model.dart';
import '../utils/message_consts.dart' as Constants;

class SharedController extends GetxController {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<bool> _isEnabled = [false, false, false, false];
  static final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");
  User user = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;

  static final errorSnackBar = ({String title, String message}) => Get.snackbar(
      title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Color.fromRGBO(252, 35, 79, 1));

  List<bool> get isEnabled => _isEnabled;
  bool get isLoading => _isLoading;

  setIsEnabled(int index, bool state) {
    _isEnabled[index] = state;
    update();
  }

  Future<CustomerModel> get getCustomerData async {
    return userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .get()
        .then((document) => CustomerModel.fromSnapshot(document));
  }

  Future<StylistModel> get getStylistData async {
    return userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .get()
        .then((document) => StylistModel.fromSnapshot(document));
  }

  Future updateSingleData(int index, String key, String value) async {
    if (formKeys[index].currentState.validate()) {
      formKeys[index].currentState.save();
      try {
        _isLoading = true;
        update();
        return await userCollection.doc(user.uid).update({
          key: value,
        }).then((value) {
          _isEnabled[index] = false;
          _isLoading = false;
          update();
          return true;
        }).catchError((error) {
          _isLoading = false;
          update();
          errorSnackBar(
              title: "Error",
              message: "Something went wrong, please try again");
          return false;
        }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
      } on TimeoutException catch (_) {
        _isLoading = false;
        update();
        errorSnackBar(
            title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MSG);
        return false;
      }
    }
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}
