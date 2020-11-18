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
import 'package:my_stylist/utils/responsive.dart';

final OnboardingController _onboardingController =
    Get.put(OnboardingController());

class NamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class AccountTypePage extends StatelessWidget {
  final String name;
  AccountTypePage({this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
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
          GetBuilder<OnboardingController>(builder: (pageTracker) {
            return DropdownButtonFormField(
              value: pageTracker.accountType,
              onChanged: (accountType) {
                pageTracker.setAccountType = accountType;
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
              decoration: textInputDecoration(hint: 'I am joining as...'),
            );
          }),
        ],
      ),
    );
  }
}

class CustomerInfoPage extends StatelessWidget {
  final String name;
  CustomerInfoPage({this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingHeader(
            txt:
                'You are almost there $name, fill out these information and press Go!',
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
                  onSaved: (customerContact) => _onboardingController
                      .setCustomerContact = customerContact,
                  validator: (phone) => ValidationService.validatePhone(phone),
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
                  onSaved: (customerLocation) => _onboardingController
                      .setCustomerLocation = customerLocation,
                  decoration: textInputDecoration(
                    hint: 'Abrepo Junction',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessInfoPage extends StatelessWidget {
  final String name;
  BusinessInfoPage({this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingHeader(
            txt:
                'You are almost there $name, fill out these information and press Go!',
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
                  validator: (businessName) => businessName.isEmpty
                      ? "Please enter your Business name"
                      : null,
                  onSaved: (businessName) =>
                      _onboardingController.setBusinessName = businessName,
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
                  validator: (phone) => ValidationService.validatePhone(phone),
                  onSaved: (businessContact) => _onboardingController
                      .setBusinessContact = businessContact,
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
                  validator: (location) =>
                      ValidationService.validateLocation(location),
                  onSaved: (businessLocation) => _onboardingController
                      .setBusinessLocation = businessLocation,
                  decoration: textInputDecoration(
                    hint: 'Abrepo Junction',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
