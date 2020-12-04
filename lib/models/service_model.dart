import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String serviceName;
  String price;
  String duration;

  ServiceModel({
    this.serviceName,
    this.price,
    this.duration,
  });

  factory ServiceModel.fromSnapshot(DocumentSnapshot serviceData) {
    return ServiceModel(
      serviceName: serviceData.data()['servicename'],
      price: serviceData.data()['price'],
      duration: serviceData.data()['duration'],
    );
  }
}
