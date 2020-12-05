import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_stylist/models/stylist_model.dart';

class ServiceModel {
  String serviceName;
  String price;
  String duration;
  String expectedBooking;
  DocumentReference serviceRef;
  DocumentReference stylistRef;

  String businessName;
  String email;
  String contact;
  String location;

  ServiceModel(
      {this.serviceName,
      this.price,
      this.duration,
      this.expectedBooking,
      this.serviceRef,
      this.stylistRef,
      this.businessName,
      this.email,
      this.contact,
      this.location});

  factory ServiceModel.fromSnapshot(QueryDocumentSnapshot serviceData) {
    // print(serviceData.reference.id);
    return ServiceModel(
      serviceRef: serviceData.reference,
      serviceName: serviceData.data()['servicename'],
      price: serviceData.data()['price'],
      duration: serviceData.data()['duration'],
      expectedBooking: serviceData.data()['numberofbookingsexpectd'],
      stylistRef: serviceData.data()['stylist_ref'],
    );
  }

  factory ServiceModel.fromModel(
      ServiceModel serviceData, StylistModel stylistData) {
    return ServiceModel(
        serviceRef: serviceData.serviceRef,
        serviceName: serviceData.serviceName,
        price: serviceData.price,
        duration: serviceData.duration,
        expectedBooking: serviceData.expectedBooking,
        stylistRef: serviceData.stylistRef,
        businessName: stylistData.businessName,
        contact: stylistData.contact,
        location: stylistData.location,
        email: stylistData.email);
  }
}
