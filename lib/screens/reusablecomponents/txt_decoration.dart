import 'package:flutter/material.dart';

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
    filled: fill,
    fillColor: fillcolor,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 0.6,
        color: Color(0xffE3E3E3),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1,
        color: Color(0xffE3E3E3),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1,
        color: Color(0xffE3E3E3),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1,
        color: Colors.red,
      ),
    ),
  );
}