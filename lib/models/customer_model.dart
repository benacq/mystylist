import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  String fullName;
  String email;
  String contact;
  String location;
  String accountType;
  DocumentReference customerRef;

  CustomerModel(
      {this.fullName,
      this.email,
      this.contact,
      this.location,
      this.customerRef,
      this.accountType});

  factory CustomerModel.fromSnapshot(QueryDocumentSnapshot customeData) {
    return CustomerModel(
        customerRef: customeData.reference,
        fullName: customeData.data()['user_fullname'],
        email: customeData.data()['email'],
        contact: customeData.data()['contact'],
        location: customeData.data()['location'],
        accountType: customeData.data()['account_type']);
  }
}
