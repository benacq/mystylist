import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';
import '../../utils/responsive.dart';


class ResetPasswordButton extends StatelessWidget {
  final Function onpress;
  final String label;
  const ResetPasswordButton({
    Key key,
    this.onpress,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: screenHeight(context, 0.07),
        width: screenWidth(context, 1),
        decoration: BoxDecoration(
          color: UiColors.color1,
          borderRadius: BorderRadiusDirectional.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: UiColors.color3,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 17,
                color: UiColors.color3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}