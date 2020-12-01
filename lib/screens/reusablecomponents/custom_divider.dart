import 'package:flutter/material.dart';
import '../../utils/responsive.dart';


class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context, 0.8),
      child: Divider(
        color: Color(0xffD6D6D6),
      ),
    );
  }
}