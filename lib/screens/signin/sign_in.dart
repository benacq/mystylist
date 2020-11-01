import 'package:flutter/material.dart';
import 'package:my_stylist/screens/signin/components/signin_body.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.darken),
              fit: BoxFit.cover,
              image: AssetImage('assets/images/loginbg.jpg'),
            ),
          ),
          child: SignInBody()),
    );
  }
}
