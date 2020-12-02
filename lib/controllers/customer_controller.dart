import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../utils/message_consts.dart' as Constants;

class CustomerController extends GetxController {
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

  Future<void> updateSingleData(int index, String key, String value) async {
    if (formKeys[index].currentState.validate()) {
      formKeys[index].currentState.save();
      try {
        _isLoading = true;
        update();
        await userCollection.doc(user.uid).update({
          key: value,
        }).then((value) {
          Fluttertoast.showToast(msg: "Data updated");
          _isEnabled[index] = false;
          _isLoading = false;
          update();
        }).catchError((error) {
          _isLoading = false;
          update();
          errorSnackBar(
              title: "Error",
              message: "Something went wrong, please try again");
        }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
      } on TimeoutException catch (_) {
        _isLoading = false;
        update();
        errorSnackBar(
            title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MESSAGE);
      }
    }
  }
}
