import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String email;
  String password;
  String uid;

  UserModel({this.email, this.password, this.uid});
}
