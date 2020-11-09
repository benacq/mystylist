import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Label extends StatelessWidget {
  final labeltext;
  const Label({this.labeltext});

  @override
  Widget build(BuildContext context) {
    return Text(
      labeltext,
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF7B7B7B),
        ),
      ),
    );
  }
}
