import 'package:flutter/material.dart';
import 'package:my_stylist/screens/signup/components/signup_body.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/loginbg.jpg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: SignUpBody(),
      ),
    );
  }
}
