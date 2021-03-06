import 'package:flutter/material.dart';
import 'package:my_stylist/controllers/auth_controller.dart';

class StylistHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () => AuthController.signOut(),
          child: Text(
            "Sign Out Stylist",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
