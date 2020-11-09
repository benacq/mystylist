import 'package:flutter/material.dart';
import 'package:my_stylist/utils/responsive.dart';

class TextboxSeperator extends StatelessWidget {
  const TextboxSeperator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context, 0.03),
    );
  }
}