import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/screens/reusablecomponents/account_data.dart';
import 'package:my_stylist/screens/reusablecomponents/custom_divider.dart';
import 'package:my_stylist/screens/reusablecomponents/header.dart';
import 'package:my_stylist/screens/reusablecomponents/logout_button.dart';
import 'package:my_stylist/screens/reusablecomponents/reset_password_button.dart';
import '../../../utils/colors.dart';
import '../../../utils/responsive.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.color2,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Asamoah MIchael',
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
                  height: screenHeight(context, 0.45),
                  width: screenWidth(context, 1),
                  decoration: BoxDecoration(
                    color: UiColors.color1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      AccountData(
                        label: 'Email',
                        value: 'qyeron@gmail.com',
                      ),
                      CustomDivider(),
                      AccountData(
                        label: 'Phone number',
                        value: '0244123456',
                      ),
                      CustomDivider(),
                      AccountData(
                        label: 'Location',
                        value: 'Kumasi',
                      ),
                      CustomDivider(),
                      AccountData(
                        label: 'Account Type',
                        value: 'Customer',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 21),
                ResetPasswordButton(
                  onpress: () {},
                  label: 'Reset password',
                ),
                SizedBox(
                  height: 24,
                ),
                LogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
