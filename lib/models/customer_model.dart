import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:my_stylist/models/user_model.dart';
part 'customer_model.g.dart';

@HiveType(typeId: 1)
class CustomerModel extends UserModel {
  @HiveField(0)
  String fullName;
  @HiveField(1)
  String email;
  @HiveField(2)
  String contact;
  @HiveField(3)
  String location;
  @HiveField(4)
  String accountType;
  @HiveField(5)
  String customerID;
  @HiveField(6)
  String region;
  DocumentReference customerRef;

  CustomerModel(
      {this.fullName,
      this.email,
      this.contact,
      this.location,
      this.customerRef,
      this.region,
      this.customerID,
      this.accountType});

  factory CustomerModel.fromSnapshot(QueryDocumentSnapshot customeData) {
    return CustomerModel(
        customerRef: customeData.reference,
        fullName: customeData.data()['user_fullname'],
        email: customeData.data()['email'],
        contact: customeData.data()['contact'],
        location: customeData.data()['location'],
        region: customeData.data()['region'],
        accountType: customeData.data()['account_type']);
  }
}
