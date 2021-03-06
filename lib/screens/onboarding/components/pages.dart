import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/controllers/onboarding_controller.dart';
import 'package:my_stylist/controllers/validation_controller.dart';
import 'package:my_stylist/screens/onboarding/components/page_header.dart';
import 'package:my_stylist/screens/reusablecomponents/label.dart';
import 'package:my_stylist/screens/reusablecomponents/label_seperator.dart';
import 'package:my_stylist/screens/reusablecomponents/textbox_seperator.dart';
import 'package:my_stylist/screens/reusablecomponents/txt_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/message_consts.dart' as Constants;

import 'package:my_stylist/utils/responsive.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingController _onboardingController =
      Get.put(OnboardingController());

  final List<String> _accountTypes = [
    'I am a Beautician',
    'I am a Customer',
  ];

  final SharedPreferences prefs;
  OnboardingPageView({this.prefs});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(builder: (pageTracker) {
      return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: OnboardingController.pageController,
          onPageChanged: (int page) {
            pageTracker.setCurrentPage = page;
          },
          children: [
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
                  Form(
                    key: OnboardingController.pv1FormKey,
                    child: TextFormField(
                      onChanged: (fullName) => prefs.setString(
                          Constants.PREF_KEY_FULLNAME, fullName),
                      initialValue: pageTracker.userFullName,
                      validator: (name) {
                        if (name.isEmpty) {
                          return "Please enter your full name";
                        } else if (name.isNum) {
                          return "Please enter a valid name";
                        }
                        return null;
                      },
                      onSaved: (fullName) =>
                          _onboardingController.setFullName = fullName,
                      decoration: textInputDecoration(
                        hint: 'Enter your full name',
                      ),
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
                        'Hello ${pageTracker.userFullName}, what best describes your purpose of joining this platform?',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetBuilder<OnboardingController>(builder: (pageTracker) {
                    return DropdownButtonFormField(
                      value: pageTracker.accountType,
                      onChanged: (accountType) {
                        prefs.setString(
                            Constants.PREF_KEY_ACC_TYPE, accountType);
                        pageTracker.setAccountType = accountType;
                      },
                      items: _accountTypes.map<DropdownMenuItem>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration:
                          textInputDecoration(hint: 'I am joining as...'),
                    );
                  }),
                ],
              ),
            ),
            (pageTracker.accountType == _accountTypes[1])
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnboardingHeader(
                          txt:
                              'You are almost there ${pageTracker.userFullName}, fill out these information and press Go!',
                        ),
                        SizedBox(
                          height: screenHeight(context, 0.05),
                        ),
                        Form(
                          key: OnboardingController.pv2FormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Label(
                                labeltext: 'Customer Contact',
                              ),
                              LabelSeperator(),
                              TextFormField(
                                onChanged: (custContact) => prefs.setString(
                                    Constants.PREF_KEY_CUST_CONTACT,
                                    custContact),
                                initialValue: pageTracker.customerContact,
                                onSaved: (customerContact) =>
                                    _onboardingController.setCustomerContact =
                                        customerContact,
                                validator: (phone) =>
                                    ValidationService.validatePhone(phone),
                                keyboardType: TextInputType.number,
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
                                onChanged: (custLocation) => prefs.setString(
                                    Constants.PREF_KEY_CUST_LOCATION,
                                    custLocation),
                                initialValue: pageTracker.customerLocation,
                                onSaved: (customerLocation) =>
                                    _onboardingController.setCustomerLocation =
                                        customerLocation,
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
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnboardingHeader(
                          txt:
                              'You are almost there ${pageTracker.userFullName}, fill out these information and press Go!',
                        ),
                        SizedBox(
                          height: screenHeight(context, 0.05),
                        ),
                        Form(
                          key: OnboardingController.pv2FormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Label(
                                labeltext: 'Business name',
                              ),
                              LabelSeperator(),
                              TextFormField(
                                onChanged: (businessName) => prefs.setString(
                                    Constants.PREF_KEY_BUSS_NAME, businessName),
                                initialValue: pageTracker.businessName,
                                validator: (businessName) =>
                                    businessName.isEmpty
                                        ? "Please enter your Business name"
                                        : null,
                                onSaved: (businessName) => _onboardingController
                                    .setBusinessName = businessName,
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
                                onChanged: (businessContact) => prefs.setString(
                                    Constants.PREF_KEY_BUSS_CONTACT,
                                    businessContact),
                                initialValue: pageTracker.businessContact,
                                validator: (phone) =>
                                    ValidationService.validatePhone(phone),
                                onSaved: (businessContact) =>
                                    _onboardingController.setBusinessContact =
                                        businessContact,
                                keyboardType: TextInputType.number,
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
                                onChanged: (location) => prefs.setString(
                                    Constants.PREF_KEY_BUSS_LOCATION, location),
                                initialValue: pageTracker.businessLocation,
                                validator: (location) =>
                                    ValidationService.validateLocation(
                                        location),
                                onSaved: (businessLocation) =>
                                    _onboardingController.setBusinessLocation =
                                        businessLocation,
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
          ]);
    });
  }
}
