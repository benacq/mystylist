import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';

class OnboardingHeader extends StatelessWidget {
  final String txt;
  const OnboardingHeader({
    this.txt,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: UiColors.color5,
          fontWeight: FontWeight.w400,
          fontSize: 17.0,
        ),
      ),
    );
  }
}