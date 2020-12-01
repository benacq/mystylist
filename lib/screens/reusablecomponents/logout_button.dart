import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 26,
          width: 26,
          decoration: BoxDecoration(
            color: Color(0XffF8E7E5).withOpacity(0.8),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            FontAwesome.power_off,
            color: Color(0XFFC0392B),
          ),
        ),
        SizedBox(
          width: 14,
        ),
        Text(
          'Logout',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: UiColors.color3,
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
