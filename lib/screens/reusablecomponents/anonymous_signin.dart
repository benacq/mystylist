import 'package:flutter/material.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/utils/colors.dart';

class SignInAnomymous extends StatelessWidget {
  final String label;

  const SignInAnomymous({this.label});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => new AuthController().onSignInAnon(),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: UiColors.color1,
          ),
        ),
      ),
    );
  }
}
