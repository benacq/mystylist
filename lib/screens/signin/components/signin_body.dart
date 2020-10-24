import 'package:flutter/material.dart';
import 'package:my_stylist/screens/reusablecomponents/anonymous_signin.dart';
import 'package:my_stylist/screens/reusablecomponents/button.dart';
import 'package:my_stylist/screens/reusablecomponents/input_decoration.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';

class SignInBody extends StatefulWidget {
  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  bool _isPasswordMasked = true;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  String get _email => _emailcontroller.text;
  String get _pass => _passwordcontroller.text;

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
              TextFormField(
                style: TextStyle(color: UiColors.color3),
                controller: _emailcontroller,
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
                controller: _passwordcontroller,
                obscureText: _isPasswordMasked,
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
                label: 'Sign In',
                onpress: () {},
              ),
              SizedBox(
                height: screenHeight(context, 0.03),
              ),
              SignInAnomymous(label: 'Skip Sign In',)
            ],
          ),
        ),
      ),
    );
  }
}


