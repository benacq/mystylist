import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class AccountData extends StatelessWidget {
  final String label;
  final Widget handlerButton;
  final Widget textFormField;
  const AccountData(
      {Key key, this.label, this.handlerButton, this.textFormField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: UiColors.color4,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(child: textFormField)
              ],
            ),
          ),
          handlerButton
        ],
      ),
    );
  }
}
