import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_stylist/models/customer_model.dart';
import 'package:my_stylist/models/user_model.dart';
import 'package:my_stylist/screens/customers/customer_navigation.dart';
import 'package:my_stylist/screens/stylist/stylist_navigation.dart';
import '../utils/message_consts.dart' as Constants;
import 'package:my_stylist/controllers/onboarding_controller.dart';

class OnboardingService {
  File _businessBanner;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FilePicker _picker = FilePicker.platform;
  final CollectionReference _stylistCollection =
      FirebaseFirestore.instance.collection("Stylists");
  final CollectionReference _customerCollection =
      FirebaseFirestore.instance.collection("Customers");
  OnboardingController _onboardingController;

  set setController(OnboardingController controller) {
    _onboardingController = controller;
  }

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

  Future<void> createBusiness() async {
    try {
      uploadBanner().then((url) {
        updateUserCredentials(photoUrl: url).then((value) async {
          await _stylistCollection.doc(_firebaseAuth.currentUser.uid).set({
            "user_fullname": _onboardingController.userFullName,
            "business_name": _onboardingController.businessName,
            "account_type": "business",
            "contact": _onboardingController.businessContact,
            "region": _onboardingController.region,
            "location": _onboardingController.businessLocation,
            // "geopoint": geopoint
          }).then((_) {
            _onboardingController.setIsLoading = false;
            _onboardingController.update();
            Get.offAll(StylistNavigation());
          }).catchError((error) {
            _onboardingController.setIsLoading = false;
            _onboardingController.update();
            messageSnackbar(
                title: "Error",
                message: "Something went wrong, please try again");
          });
        });
      }).timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
    } on TimeoutException catch (_) {
      _onboardingController.setIsLoading = false;
      _onboardingController.update();
      messageSnackbar(
          title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MSG);
    }
  }

  Future<void> createCustomer() async {
    try {
      updateUserCredentials()
          .then((value) async => {
                await _customerCollection
                    .doc(_firebaseAuth.currentUser.uid)
                    .set({
                  "user_fullname": _onboardingController.userFullName,
                  "account_type": "customer",
                  "contact": _onboardingController.customerContact,
                  "region": _onboardingController.region,
                  "location": _onboardingController.customerLocation,
                }).then((_) {
                  _onboardingController.setIsLoading = false;
                  _onboardingController.update();
                  Get.offAll(CustomerNavigation());
                }).catchError((error) {
                  _onboardingController.setIsLoading = false;
                  _onboardingController.update();
                  messageSnackbar(
                      title: "Error",
                      message: "Something went wrong, please try again");
                })
              })
          .timeout(new Duration(seconds: Constants.TIMEOUT_SECS));
    } on TimeoutException catch (_) {
      _onboardingController.setIsLoading = false;
      _onboardingController.update();
      messageSnackbar(
          title: Constants.TIMEOUT_TITLE, message: Constants.TIMEOUT_MSG);
    }
  }

  Future<bool> updateUserCredentials({String photoUrl}) async {
    return await _firebaseAuth.currentUser
        .updateProfile(
            displayName: _onboardingController.userFullName,
            photoURL: photoUrl ?? null)
        .then((value) => true);
  }

  Future<String> uploadBanner() async {
    if (_businessBanner != null) {
      try {
        firebase_storage.TaskSnapshot taskSnapshot = await storage
            .ref()
            .child("stylists/banners/{serviceID}}")
            .putFile(_businessBanner);

        return taskSnapshot.ref.getDownloadURL().then((url) => url);
      } on FirebaseException catch (e) {
        print("*********** ${e.toString()} **************");
        return e.code;
      }
    }
    Fluttertoast.showToast(msg: "Please choose a banner");
    return null;
  }

  Future getImage() async {
    await _picker
        .pickFiles(
      type: FileType.image,
      allowMultiple: false,
      allowCompression: true,
    )
        .then((pickerResult) {
      if (pickerResult != null) {
        _businessBanner = File(pickerResult.paths[0]);
      } else {
        Fluttertoast.showToast(msg: "No banner selected");
      }
    }).catchError((error) {
      print(error.toString());
      if (error.runtimeType == PlatformException) {
        switch (error.code) {
          case "read_external_storage_denied":
            Fluttertoast.showToast(msg: "Storage permission denied");
            break;
          default:
            Fluttertoast.showToast(msg: "Something went wrong");
        }
      } else {
        print(
            "********************************** ${error.toString()} *************************************");
      }
    });
  }

  saveToHive(String boxName, UserModel model) async {
    await Hive.openBox(boxName).then((Box box) {
      box
          .put(_firebaseAuth.currentUser.uid, model)
          .then((value) => {box.close()});
    });
  }
}
