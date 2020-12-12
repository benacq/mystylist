import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_stylist/screens/signin/sign_in.dart';
import 'package:my_stylist/screens/signup/sign_up.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';

class LBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              'Welcome',
              style: TextStyle(
                color: UiColors.color1,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: screenHeight(context, 0.01),
            ),
            Text(
              'Create an account with us or sign into your existing account and start booking your favorite stylist!',
              style: TextStyle(
                color: UiColors.color1,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: screenHeight(context, 0.07),
            ),
            Container(
              width: screenWidth(context, 1),
              height: screenHeight(context, 0.08),
              child: RaisedButton(
                onPressed: () {
                  Get.to(SignIn());
                },
                color: UiColors.color1,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: UiColors.color3,
                    fontSize: 20.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight(context, 0.02),
            ),
            Container(
              width: screenWidth(context, 1),
              height: screenHeight(context, 0.08),
              child: OutlineButton(
                onPressed: () {
                  Get.to(SignUp());
                },
                borderSide: BorderSide(
                  color: UiColors.color1,
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: UiColors.color1,
                    fontSize: 20.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
