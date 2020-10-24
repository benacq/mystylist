  import 'package:flutter/material.dart';
import 'package:my_stylist/utils/colors.dart';

InputDecoration buildInputDecoration({
    String label,
    Icon picon,
    IconButton sicon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: picon,
      suffixIcon: sicon,
      labelStyle: TextStyle(color: UiColors.color3),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 0.6,
          color: UiColors.color3,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 0.3,
          color: UiColors.color5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: UiColors.color1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: UiColors.color1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: Colors.red,
        ),
      ),
    );
  }