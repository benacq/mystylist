import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/controllers/onboarding_controller.dart';
import 'package:my_stylist/controllers/validation_controller.dart';
import 'package:my_stylist/models/regions_model.dart';
import 'package:my_stylist/screens/onboarding/components/page_header.dart';
import 'package:my_stylist/screens/reusablecomponents/label.dart';
import 'package:my_stylist/screens/reusablecomponents/label_seperator.dart';
import 'package:my_stylist/screens/reusablecomponents/textbox_seperator.dart';
import 'package:my_stylist/screens/reusablecomponents/txt_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/colors.dart';
import '../../../utils/message_consts.dart' as Constants;

import 'package:my_stylist/utils/responsive.dart';

class OnboardingPageView extends StatefulWidget {
  @override
  _OnboardingPageViewState createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final OnboardingController _onboardingController =
      Get.put(OnboardingController());

  String selectedRegion = 'Greater Accra';
  List<DropdownMenuItem> get getDRopDownItems {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String region in regionList) {
      var newItem = DropdownMenuItem(child: Text(region), value: region);
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  final List<String> _accountTypes = [
    'I am a Beautician',
    'I am a Customer',
  ];

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
                        color: UiColors.color3,
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
                      style: TextStyle(color: UiColors.color3),
                      // onChanged: null
                      // (fullName) => pageTracker.preferences
                      //     .setString(Constants.PREF_KEY_FULLNAME, fullName)

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
                        'Hello ${pageTracker.userFullName}, which region are you in and what best describes your purpose of joining this platform a?',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetBuilder<OnboardingController>(builder: (pageTracker) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label(
                          labeltext: 'Purpose of joining',
                        ),
                        LabelSeperator(),
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: UiColors.color1,
                          ),
                          child: DropdownButtonFormField(
                            style: TextStyle(color: UiColors.color3),
                            value: pageTracker.accountType,
                            onChanged: (accountType) =>
                                pageTracker.setAccountType = accountType,
                            items: _accountTypes.map<DropdownMenuItem>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration:
                                textInputDecoration(hint: 'I am joining as...'),
                          ),
                        ),
                        TextboxSeperator(),
                        Label(
                          labeltext: 'Region',
                        ),
                        LabelSeperator(),
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: UiColors.color1,
                          ),
                          child: DropdownButtonFormField(
                            style: TextStyle(color: UiColors.color3),
                            value: pageTracker.region,
                            items: getDRopDownItems,
                            onChanged: (region) =>
                                pageTracker.setRegion = region,
                            decoration:
                                textInputDecoration(hint: 'Select a region.'),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            (pageTracker.accountType == _accountTypes[1])
                ? Padding(
                    padding: const EdgeInsets.only(top: 50.0),
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
                                style: TextStyle(color: UiColors.color3),
                                // onChanged: null
                                //  (custContact) =>
                                //     widget.prefs.setString(
                                //   Constants.PREF_KEY_CUST_CONTACT,
                                //   custContact,
                                // )

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
                                style: TextStyle(color: UiColors.color3),
                                // onChanged: null
                                // (custLocation) => widget.prefs
                                //     .setString(Constants.PREF_KEY_CUST_LOCATION,
                                //         custLocation)

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
                    padding: const EdgeInsets.only(top: 50.0),
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
                                style: TextStyle(color: UiColors.color3),
                                // onChanged: null
                                // (businessName) => widget.prefs
                                //     .setString(Constants.PREF_KEY_BUSS_NAME,
                                //         businessName)

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
                                style: TextStyle(color: UiColors.color3),
                                // onChanged: null
                                // (businessContact) => widget.prefs
                                //     .setString(Constants.PREF_KEY_BUSS_CONTACT,
                                //         businessContact)

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
                                style: TextStyle(color: UiColors.color3),
                                // onChanged: null,
                                // (location) => widget.prefs.setString(
                                //     Constants.PREF_KEY_BUSS_LOCATION, location),
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
                              SizedBox(height: 5),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => _onboardingController
                                          .onboardingService
                                          .getImage(),
                                      child: Text(
                                        'Upload a banner',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesome.image,
                                      color: UiColors.color8,
                                    ),
                                  ],
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
