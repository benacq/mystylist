import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/screens/customers/home/customer_home.dart';
import 'package:my_stylist/screens/onboarding/components/page_header.dart';
import 'package:my_stylist/screens/reusablecomponents/label.dart';
import 'package:my_stylist/screens/reusablecomponents/label_seperator.dart';
import 'package:my_stylist/screens/reusablecomponents/textbox_seperator.dart';
import 'package:my_stylist/screens/reusablecomponents/txt_decoration.dart';
import 'package:my_stylist/utils/responsive.dart';

import 'components/onboarding_progress_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  String dropdownValue;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool selected; //true = beautician false = customer
  TextEditingController namecontroller = TextEditingController();
  TextEditingController businessnamecontroller = TextEditingController();
  TextEditingController businesscontactcontroller = TextEditingController();
  TextEditingController customercontactcontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  String get name => namecontroller.text;
  String get businessname => businessnamecontroller.text;
  String get businesscontact => businesscontactcontroller.text;
  String get customercontact => customercontactcontroller.text;
  String get location => locationcontroller.text;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? indicator(true) : indicator(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: screenHeight(context, 0.7),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28.0,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight(context, 0.06)),
                            OnboardingHeader(
                              txt:
                                  'We are going to guide you through setting up your account, First tell us your name?',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: namecontroller,
                              decoration: textInputDecoration(
                                hint: 'Enter your full name',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OnboardingHeader(
                              txt:
                                  'Hello $name, what best describes your purpose of joining this platform?',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownButtonFormField(
                              value: dropdownValue,
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: [
                                'I am a Beautician',
                                'I am a Customer',
                              ].map<DropdownMenuItem>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: textInputDecoration(
                                  hint: 'I am joining as...'),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          dropdownValue == 'I am a Beautician'
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 50.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      OnboardingHeader(
                                        txt:
                                            'You are almost there $name, fill out these information and press Go!',
                                      ),
                                      SizedBox(
                                        height: screenHeight(context, 0.05),
                                      ),
                                      Form(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Label(
                                              labeltext: 'Business name',
                                            ),
                                            LabelSeperator(),
                                            TextFormField(
                                              controller:
                                                  businessnamecontroller,
                                              decoration: textInputDecoration(
                                                hint: 'Gye nyame saloon',
                                              ),
                                            ),
                                            TextboxSeperator(),
                                            Label(
                                              labeltext: 'Business Contact',
                                            ),
                                            LabelSeperator(),
                                            TextFormField(
                                              controller:
                                                  businesscontactcontroller,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: textInputDecoration(
                                                hint: '+233204123456',
                                              ),
                                            ),
                                            TextboxSeperator(),
                                            Label(
                                              labeltext: 'Location',
                                            ),
                                            LabelSeperator(),
                                            TextFormField(
                                              controller: locationcontroller,
                                              decoration: textInputDecoration(
                                                hint: 'Abrepo Junction',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 50.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      OnboardingHeader(
                                        txt:
                                            'You are almost there $name, fill out these information and press Go!',
                                      ),
                                      SizedBox(
                                        height: screenHeight(context, 0.05),
                                      ),
                                      Form(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Label(
                                              labeltext: 'Customer Contact',
                                            ),
                                            LabelSeperator(),
                                            TextFormField(
                                              controller:
                                                  customercontactcontroller,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: textInputDecoration(
                                                hint: '+233204123456',
                                              ),
                                            ),
                                            TextboxSeperator(),
                                            Label(
                                              labeltext: 'Location',
                                            ),
                                            LabelSeperator(),
                                            TextFormField(
                                              controller: locationcontroller,
                                              decoration: textInputDecoration(
                                                hint: 'Abrepo Junction',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage == 0
                    ? Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: FlatButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          color: Color(
                            0xffDEDEDE,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 25,
                            ),
                            child: Text(
                              _currentPage == 2 ? 'Go' : 'Next',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 35.0, horizontal: 60),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlineButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                borderSide: BorderSide(
                                    color: Color(0xFFADADAD), width: 1.4),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                  ),
                                  child: Text(
                                    'Back',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth(context, 0.1),
                            ),
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  _currentPage != 2
                                      ? _pageController.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        )
                                      : Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerHome(),
                                          ),
                                        );
                                },
                                color: Color(0xffDEDEDE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                  ),
                                  child: Text(
                                    _currentPage == 2 ? 'Go' : 'Next',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
