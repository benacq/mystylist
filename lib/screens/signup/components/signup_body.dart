import 'package:flutter/material.dart';
import 'package:my_stylist/screens/reusablecomponents/anonymous_signin.dart';
import 'package:my_stylist/screens/reusablecomponents/button.dart';
import 'package:my_stylist/screens/reusablecomponents/input_decoration.dart';
import 'package:my_stylist/services/signup_services.dart';
import 'package:my_stylist/services/validation_services.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';

class SignUpBody extends StatefulWidget {
  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  bool _isPasswordMasked = true;
  SignUpService _signUpService = new SignUpService();

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
                color: UiColors.color3,
              ),
              SizedBox(
                height: screenHeight(context, 0.15),
              ),
              Text(
                'Create \nAccount',
                style: TextStyle(
                  color: UiColors.color3,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight(context, 0.2),
              ),
              Form(
                key: SignUpService.signUpFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (email) =>
                          ValidationService.validateEmail(email),
                      style: TextStyle(color: UiColors.color3),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (email) => _signUpService.setEmail = email,
                      decoration: buildInputDecoration(
                        label: 'Email',
                        picon: Icon(
                          Icons.email,
                          color: UiColors.color3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.02),
                    ),
                    TextFormField(
                      style: TextStyle(color: UiColors.color3),
                      validator: (password) =>
                          ValidationService.validatePassword(password),
                      obscureText: _isPasswordMasked,
                      onSaved: (password) =>
                          _signUpService.setPassword = password,
                      decoration: buildInputDecoration(
                        label: 'Password',
                        picon: Icon(
                          Icons.lock,
                          color: UiColors.color3,
                        ),
                        sicon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordMasked = !_isPasswordMasked;
                            });
                          },
                          icon: Icon(
                            _isPasswordMasked
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: UiColors.color3,
                            size: 23.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.02),
                    ),
                    ReusableButton(
                      label: 'Sign Up',
                      onpress: () => _signUpService.onSignUp(),
                    ),
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
