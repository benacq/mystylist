import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_stylist/models/service_model.dart';
import 'package:my_stylist/models/stylist_model.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:rxdart/rxdart.dart';

class StylistController extends GetxController {
  static final GlobalKey<FormState> addServiceFormKey = GlobalKey<FormState>();
  String _uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  CollectionReference services =
      FirebaseFirestore.instance.collection('services');

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

  // Stream<List<ServiceModel>> fetchServicesWithStylists() {
  //   return Rx.combineLatest2(stylists(), getServices(),
  //       (List<StylistModel> stylistBusiness, List<ServiceModel> services) {
  //     print(stylistBusiness.length);
  //     return stylistBusiness.map((stylist) {
  //       final servicesData = services?.firstWhere(
  //           (cart) => cart.stylistRef.id == stylist.stylistRef.id,
  //           orElse: () => null);
  //       if (servicesData != null) {
  //         print(servicesData.serviceName);
  //         return ServiceModel.fromModel(servicesData, stylist);
  //       }
  //     }).toList();
  //   });
  // }

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
}
