import 'package:flutter/material.dart';
import 'package:my_stylist/controllers/auth_controller.dart';

import '../../../utils/colors.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.color2,
      body: Center(
        child: RaisedButton(
          onPressed: () => AuthController.signOut(),
          child: Text(
            "Sign Out Customer",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
