import 'package:flutter/material.dart';

Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 6.0,
      decoration: BoxDecoration(
          color: isActive ? Color(0xFF62B750) : Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Color(0xFF62B750))),
    );
  }