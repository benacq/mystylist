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

  static final errorSnackBar = ({String title, String message}) => Get.snackbar(
      title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Color.fromRGBO(252, 35, 79, 1));

  List<bool> get isEnabled => _isEnabled;

  setIsEnabled(int index, bool state) {
    _isEnabled[index] = state;
    update();
  }

  Future<void> updateSingleData(int index, String key, String value) async {
    print("HELLO");
    if (formKeys[index].currentState.validate()) {
      formKeys[index].currentState.save();
      try {
        await userCollection.doc(user.uid).update({
          key: value,
        }).whenComplete(() {
          Fluttertoast.showToast(msg: "Data updated");
          _isEnabled[index] = false;
          update();
        }).catchError((error) {
          errorSnackBar(
              title: "Error",
              message: "Something went wrong, please try again");
        }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
      } on TimeoutException catch (_) {
        errorSnackBar(
            title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MESSAGE);
      }
    }
  }
}
