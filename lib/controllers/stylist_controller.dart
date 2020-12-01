import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_stylist/models/stylist_model.dart';

class StylistController {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  Stream<List<StylistModel>> get stylists {
    return users.where("account_type", isEqualTo: "business").snapshots().map(
        (shopSnapshot) => shopSnapshot.docs
            .map((e) => StylistModel.fromSnapshot(e))
            .toList());
  }

  Stream<List<StylistModel>> featuredStylists() {
    return users
        .where("account_type", isEqualTo: "business")
        .where("featured", isEqualTo: true)
        .snapshots()
        .map((shopSnapshot) => shopSnapshot.docs
            .map((e) => StylistModel.fromSnapshot(e))
            .toList());
  }
}
