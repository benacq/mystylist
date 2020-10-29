import 'package:flutter/material.dart';
import 'package:my_stylist/utils/responsive.dart';

class ReusableButton extends StatelessWidget {
  final Function onpress;
  final String label;
  const ReusableButton({this.label, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context, 0.08),
      width: screenWidth(context, 1),
      child: RaisedButton(
        onPressed: onpress,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label),
      ),
    );
  }
}
