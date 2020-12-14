import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/controllers/shared_controller.dart';
import 'package:my_stylist/models/stylist_model.dart';
import 'package:my_stylist/screens/reusablecomponents/header.dart';
import 'package:my_stylist/screens/reusablecomponents/logout_button.dart';
import 'package:my_stylist/screens/reusablecomponents/reset_password_button.dart';
import 'package:my_stylist/screens/stylist/account/account_fields.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/message_consts.dart' as Constants;

class StylistAccount extends StatefulWidget {
  @override
  _StylistAccountState createState() => _StylistAccountState();
}

class _StylistAccountState extends State<StylistAccount> {
  final InputDecoration inputDecoration = InputDecoration(
      enabled: true, border: InputBorder.none, isCollapsed: true);

  final GlobalKey<FormState> passwordFormkey = GlobalKey<FormState>();

  String password;

  final TextStyle googleFonts = GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: UiColors.color3,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.color2,
      body: FutureBuilder<StylistModel>(
          future: SharedController().getStylistData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // return Center(child: Constants.LOADER);
              return Center(
                child: LogoutButton(
                  logout: () => AuthController.signOut(),
                ),
              );
            }
            StylistModel stylistModel = snapshot.data;
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stylistModel.businessName,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: UiColors.color4,
                                ),
                              ),
                            ),
                            Text(
                              stylistModel.ownerFullName,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7B7B7B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Container(
                        // height: 370,
                        // width: screenWidth(context, 1),
                        decoration: BoxDecoration(
                          color: UiColors.color1,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: StylistAccountFields(model: stylistModel)),
                    SizedBox(height: 21),
                    ResetPasswordButton(
                      onpress: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('Change password'),
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
                                              // AuthController()
                                              //     .changePassword(password)
                                              //     .whenComplete(() =>
                                              //         Navigator.of(context)
                                              //             .pop());
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
