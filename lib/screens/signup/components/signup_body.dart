import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/controllers/validation_controller.dart';
import 'package:my_stylist/screens/reusablecomponents/anonymous_signin.dart';
import 'package:my_stylist/screens/reusablecomponents/button.dart';
import 'package:my_stylist/screens/reusablecomponents/input_decoration.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';

class SignUpBody extends GetWidget<AuthController> {
  // final bool _isPasswordMasked = true;

  final loader = SpinKitFadingFour(
    color: Colors.blueAccent,
    size: 35.0,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: UiColors.color1,
              ),
              SizedBox(
                height: screenHeight(context, 0.15),
              ),
              Text(
                'Create \nAccount',
                style: TextStyle(
                  color: UiColors.color1,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight(context, 0.2),
              ),
              Form(
                key: AuthController.signUpFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (email) =>
                          ValidationService.validateEmail(email),
                      style: TextStyle(color: UiColors.color1),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (email) => controller.setEmail = email,
                      decoration: buildInputDecoration(
                        label: 'Email',
                        picon: Icon(
                          Icons.email,
                          color: UiColors.color1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.02),
                    ),
                    GetBuilder<AuthController>(
                        init: AuthController(),
                        builder: (_) {
                          return TextFormField(
                            style: TextStyle(color: UiColors.color1),
                            validator: (password) =>
                                ValidationService.validatePassword(password),
                            obscureText: _.isPasswordMasked,
                            onSaved: (password) =>
                                controller.setPassword = password,
                            decoration: buildInputDecoration(
                              label: 'Password',
                              picon: Icon(
                                Icons.lock,
                                color: UiColors.color1,
                              ),
                              sicon: IconButton(
                                onPressed: () => _.togglePasswordMask(),
                                icon: Icon(
                                  _.isPasswordMasked
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: UiColors.color1,
                                  size: 23.0,
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: screenHeight(context, 0.02),
                    ),
                    GetBuilder<AuthController>(
                        init: AuthController(),
                        builder: (_) {
                          return ReusableButton(
                            label: _.isLoading
                                ? loader
                                : Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: UiColors.color1,
                                    ),
                                  ),
                            onpress: () => controller.onSignUp(),
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context, 0.03),
              ),
              SignInAnomymous(
                label: 'Skip Sign Up',
              )
            ],
          ),
        ),
      ),
    );
  }
}
