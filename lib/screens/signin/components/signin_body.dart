import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/screens/reusablecomponents/anonymous_signin.dart';
import 'package:my_stylist/screens/reusablecomponents/button.dart';
import 'package:my_stylist/screens/reusablecomponents/input_decoration.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';

// class SignInBody extends StatefulWidget {
//   @override
//   _SignInBodyState createState() => _SignInBodyState();
// }

class SignInBody extends GetWidget<AuthController> {
  // final SignInController _signInService = new SignInController();
  final _isPasswordMasked = true;
  // String _email;
  // String _password;

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
                'Welcome \nBack',
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
                key: AuthController.signInFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: UiColors.color3),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (email) => controller.setEmail = email,
                      validator: (email) =>
                          email.isEmpty ? "Please enter your email" : null,
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
                      validator: (password) => password.isEmpty
                          ? "Please enter your password"
                          : null,
                      onSaved: (password) => controller.setPassword = password,
                      obscureText: _isPasswordMasked,
                      decoration: buildInputDecoration(
                        label: 'Password',
                        picon: Icon(
                          Icons.lock,
                          color: UiColors.color3,
                        ),
                        sicon: IconButton(
                          onPressed: () {
                            print("Mask password");
                            // setState(() {
                            //   _isPasswordMasked = !_isPasswordMasked;
                            // });
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
                      label: 'Sign In',
                      onpress: () => controller.onSignIn(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context, 0.03),
              ),
              SignInAnomymous(
                label: 'Skip Sign In',
              )
            ],
          ),
        ),
      ),
    );
  }
}
