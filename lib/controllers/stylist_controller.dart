import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:my_stylist/models/service_model.dart';
import 'package:my_stylist/models/stylist_model.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class StylistController extends GetxController {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  static final GlobalKey<FormState> addServiceFormKey = GlobalKey<FormState>();
  String _uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  CollectionReference services =
      FirebaseFirestore.instance.collection('services');
  int _maxNumFilesAllowed = 5;
  List<File> _images = List();

  static final FilePicker _picker = FilePicker.platform;

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

  String _serviceName;
  String _price;
  String _duration;
  String _numberOfBookingsExpected;
  bool _isLoading = false;

  //getters adding services
  String get serviceName => _serviceName;
  String get price => _price;
  String get duration => _duration;
  String get numberofBookingsExpected => _numberOfBookingsExpected;
  bool get isLoading => _isLoading;

//setters for adding services
  set setserviceName(String serviceName) {
    if (serviceName != null) {
      _serviceName = serviceName;
    }
  }

  set setprice(String price) {
    if (price != null) {
      _price = price;
    }
  }

  set setduration(String duration) {
    if (duration != null) {
      _duration = duration;
    }
  }

  set setnumberofBookingsExpected(String numberofBookingsExpected) {
    if (numberofBookingsExpected != null) {
      _numberOfBookingsExpected = numberofBookingsExpected;
    }
  }

  Stream<List<StylistModel>> stylists() {
    return users
        .where("account_type", isEqualTo: "business")
        .snapshots()
        .map((shopSnapshot) {
      return shopSnapshot.docs.map((e) {
        return StylistModel.fromSnapshot(e);
      }).toList();
    });
  }

  Stream<List<ServiceModel>> getServices(DocumentReference stylistRef) {
    return services
        .where('stylist_ref', isEqualTo: stylistRef)
        .snapshots()
        .map((serviceSnapshot) {
      return serviceSnapshot.docs.map((element) {
        return ServiceModel.fromSnapshot(element);
      }).toList();
    });
  }

  Stream<List<StylistModel>> featuredStylists() {
    return users
        .where("account_type", isEqualTo: "business")
        .where("featured", isEqualTo: true)
        .snapshots()
        .map((businessSnapshot) => businessSnapshot.docs
            .map((e) => StylistModel.fromSnapshot(e))
            .toList());
  }

//add service
  Future<void> addService() async {
    if (!addServiceFormKey.currentState.validate()) {
      return;
    }
    addServiceFormKey.currentState.save();
    try {
      _isLoading = true;
      update();
      var result = await services.doc().set({
        'servicename': _serviceName,
        'price': _price,
        'duration': _duration,
        'numberofbookingsexpectd': _numberOfBookingsExpected,
        'stylist_ref': users.doc(_uid),
      });
      Fluttertoast.showToast(msg: 'Service added');
      addServiceFormKey.currentState.reset();
      _isLoading = false;
      update();
      return result;
    } catch (e) {
      _isLoading = false;
      update();
      throw e;
    }
  }

  Future getImage() async {
    await _picker
        .pickFiles(
      type: FileType.image,
      allowMultiple: true,
      allowCompression: true,
    )
        .then((pickerResult) {
      if (pickerResult != null) {
        _images.addAll(pickerResult.paths.map((path) => File(path)).toList());
        print("********************* $_images **************************");
        if (_images.length > _maxNumFilesAllowed) {
          _images.sublist(0, 5);
          Fluttertoast.showToast(msg: "You can select a maximum of 5 images");
          print("********************* $_images **************************");
        }
      } else {
        Fluttertoast.showToast(msg: "No image selected");
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
        Fluttertoast.showToast(msg: "No file selected");
      }
    });
  }

  Future<dynamic> uploadPhotos(String serviceID) async {
    try {
      print(_images);
      if (_images != null && _images.isNotEmpty) {
        List<String> photoDownloadUrls = [];
        _images.forEach((imageFile) async {
          firebase_storage.TaskSnapshot taskSnapshot = await storage
              .ref()
              .child(
                  "stylists/services/${serviceID}__${basename(imageFile.path)}")
              .putFile(imageFile);

          taskSnapshot.ref.getDownloadURL().then((url) {
            print("Image sent");
            photoDownloadUrls.add(url);
            //insert url to database
          }).catchError((error) {
            //
          });
        });
      } else {
        print("No photo found");
      }
    } on PlatformException catch (e) {
      print(e.message);
      return e;
    }
  }
}
