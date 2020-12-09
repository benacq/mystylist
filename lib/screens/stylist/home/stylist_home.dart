import 'package:flutter/material.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/controllers/stylist_controller.dart';

class StylistHome extends StatelessWidget {
  final StylistController stylistController = new StylistController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () => AuthController.signOut(),
                child: Text(
                  "Sign Out Stylist",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueAccent,
              ),
              SizedBox(height: 50),
              RaisedButton(
                onPressed: () {
                  stylistController.getImage();
                },
                child: Text(
                  "Select photos",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueAccent,
              ),
              RaisedButton(
                onPressed: () {
                  stylistController.uploadPhotos("asdfegr44tgw6264wf");
                },
                child: Text(
                  "Send photo",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
