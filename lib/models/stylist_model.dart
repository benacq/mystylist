import 'package:cloud_firestore/cloud_firestore.dart';

class StylistModel {
  String businessName;
  String ownerFullName;
  String email;
  String contact;
  String location;
  bool featured;
  String accountType;
  DocumentReference businessRef;

  StylistModel(
      {this.businessName,
      this.ownerFullName,
      this.email,
      this.contact,
      this.location,
      this.featured,
      this.businessRef,
      this.accountType});

  factory StylistModel.fromSnapshot(DocumentSnapshot stylistData) {
    return StylistModel(
        businessRef: stylistData.reference,
        businessName: stylistData.data()['business_name'],
        ownerFullName: stylistData.data()['user_fullname'],
        email: stylistData.data()['email'],
        contact: stylistData.data()['contact'],
        location: stylistData.data()['location'],
        featured: stylistData.data()['featured'],
        accountType: stylistData.data()['account_type']);
  }
}
