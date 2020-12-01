import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class PageHeader extends StatelessWidget {
  final String header;
  const PageHeader({
    this.header
  }) ;

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: UiColors.color3,
          fontWeight: FontWeight.w700,
          fontSize: 28.0,
        ),
      ),
    );
  }
}

