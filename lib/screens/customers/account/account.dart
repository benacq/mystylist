import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/controllers/shared_controller.dart';
import 'package:my_stylist/models/customer_model.dart';
import 'package:my_stylist/screens/customers/account/components/account_fields.dart';
import 'package:my_stylist/screens/reusablecomponents/header.dart';
import 'package:my_stylist/screens/reusablecomponents/logout_button.dart';
import 'package:my_stylist/screens/reusablecomponents/reset_password_button.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/message_consts.dart' as Constants;

import '../../../utils/colors.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final GlobalKey<FormState> passwordFormkey = GlobalKey<FormState>();
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.color2,
      body: FutureBuilder<CustomerModel>(
          future: SharedController().getCustomerData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Constants.LOADER);
            }
            CustomerModel customerModel = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    PageHeader(header: 'Account'),
                    SizedBox(height: 13),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 35,
                          width: 31,
                          decoration: BoxDecoration(
                            color: Color(0XFFBE44AD),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            FontAwesome.cog,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          customerModel.fullName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: UiColors.color4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: UiColors.color1,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AccountFields(model: customerModel)),
                    SizedBox(height: 21),
                    ResetPasswordButton(
                      onpress: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('Reset password'),
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Form(
                                        key: passwordFormkey,
                                        child: TextFormField(
                                          validator: (value) => value.isEmpty
                                              ? "Enter a password"
                                              : null,
                                          onSaved: (newValue) =>
                                              password = newValue,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              hintText: "Enter new password"),
                                        ),
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            if (passwordFormkey.currentState
                                                .validate()) {
                                              passwordFormkey.currentState
                                                  .save();
                                              AuthController()
                                                  .changePassword(password)
                                                  .whenComplete(() =>
                                                      Navigator.of(context)
                                                          .pop());
                                            }
                                            return;
                                          },
                                          child: Text("Save"))
                                    ],
                                  ),
                                ));
                      },
                      label: 'Reset password',
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    LogoutButton(
                      logout: () => AuthController.signOut(),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
