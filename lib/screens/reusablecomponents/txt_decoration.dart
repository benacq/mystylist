import 'package:flutter/material.dart';

import '../../utils/colors.dart';

InputDecoration textInputDecoration({
  String hint,
  Icon picon,
  IconButton sicon,
  bool fill,
  Color fillcolor,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Color(0xffB0B0B0)),
    prefixIcon: picon,
    suffixIcon: sicon,
    labelStyle: TextStyle(color: Color(0xff9A9A9A)),
    filled: true,
    fillColor: UiColors.color1,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        width: 0.6,
        color: UiColors.color1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        width: 1,
        color: UiColors.color1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        width: 1,
        color: UiColors.color1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        width: 1,
        color: Colors.red,
      ),
    ),
  );
}