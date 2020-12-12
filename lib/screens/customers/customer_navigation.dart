import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/screens/customers/account/account.dart';

import '../../utils/colors.dart';
import 'home/customer_home.dart';

class CustomerNavigation extends StatefulWidget {
  @override
  _CustomerNavigationState createState() => _CustomerNavigationState();
}

class _CustomerNavigationState extends State<CustomerNavigation> {
  int currentIndex = 0;

  final bottomItems = [
    {'icon': Icon(FontAwesome.home), 'text': 'Home'},
    {"icon": Icon(FontAwesome.clipboard), 'text': 'Appointments'},
    {"icon": Icon(FontAwesome.cog), 'text': 'Account'},
  ];

  final pages = [
    CustomerHome(),
    CustomerHome(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: UiColors.color2,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0),
        height: height / 10,
        decoration: BoxDecoration(
          color: UiColors.color1,
        ),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bottomItems
                .asMap()
                .map((i, icon) {
                  bool active = i == currentIndex;
                  final color = active ? UiColors.color8 : Color(0Xff999999);
                  Widget button;

                  button = Column(
                    children: <Widget>[
                      IconButton(
                        icon: icon["icon"],
                        color: color,
                        onPressed: () => setState(() => currentIndex = i),
                      ),
                      active
                          ? Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: UiColors.color8,
                              ),
                            )
                          : Text(
                              icon["text"].toString(),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                    ],
                  );
                  return MapEntry(i, button);
                })
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}
