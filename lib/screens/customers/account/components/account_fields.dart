import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/controllers/shared_controller.dart';
import 'package:my_stylist/models/customer_model.dart';
import 'package:my_stylist/screens/reusablecomponents/account_data.dart';
import 'package:my_stylist/controllers/validation_controller.dart';
import 'package:my_stylist/screens/reusablecomponents/custom_divider.dart';
import 'package:my_stylist/utils/colors.dart';

class AccountFields extends StatefulWidget {
  final CustomerModel model;
  AccountFields({this.model});
  @override
  _AccountFieldsState createState() => _AccountFieldsState();
}

class _AccountFieldsState extends State<AccountFields> {
  SharedController sharedController = Get.put(SharedController());

  final loading = SpinKitThreeBounce(
    color: Colors.white,
    size: 12.0,
  );

  FocusNode emailFocus = new FocusNode();

  String email;
  String location;
  String contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<SharedController>(builder: (state) {
          return GestureDetector(
            child: AccountData(
              label: 'Email',
              textFormField: Form(
                key: SharedController.formKeys[0],
                child: TextFormField(
                    focusNode: emailFocus,
                    onSaved: (newValue) => email = newValue,
                    validator: (email) =>
                        ValidationService.validateEmail(email),
                    initialValue: widget.model.email,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: state.isEnabled[0]
                            ? UiColors.color3
                            : Color.fromRGBO(209, 209, 209, 1),
                      ),
                    ),
                    cursorColor: UiColors.color3,
                    decoration: InputDecoration(
                        enabled: state.isEnabled[0],
                        border: InputBorder.none,
                        isCollapsed: true)),
              ),
              handlerButton: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FormState formState =
                      SharedController.formKeys[0].currentState;

                  if (formState.validate()) {
                    formState.save();
                    if (!email.isNull && email != widget.model.email) {
                      AuthController().changeEmail(email).then((wasSuccess) {
                        if (wasSuccess) {
                          state
                              .updateSingleData(0, "email", email)
                              .then((value) {
                            if (value == true) {
                              Fluttertoast.showToast(msg: "Updated");
                              return;
                            }
                          });
                          return;
                        }
                        state.setIsEnabled(0, !state.isEnabled[0]);
                      });
                    } else {
                      state.setIsEnabled(0, !state.isEnabled[0]);
                    }
                  }
                },
                child: !state.isEnabled[0]
                    ? Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: UiColors.color3,
                      )
                    : !state.isLoading
                        ? Text(
                            "Save",
                            style: TextStyle(color: Colors.red),
                          )
                        : loading,
              ),
            ),
            onTap: () => state.setIsEnabled(0, true),
          );
        }),
        CustomDivider(),
        GetBuilder<SharedController>(builder: (state) {
          return GestureDetector(
            child: AccountData(
              label: 'Phone number',
              textFormField: Form(
                key: SharedController.formKeys[1],
                child: TextFormField(
                    onSaved: (newValue) => contact = newValue,
                    validator: (phone) =>
                        ValidationService.validatePhone(phone),
                    initialValue: widget.model.contact,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: state.isEnabled[1]
                            ? UiColors.color3
                            : Color.fromRGBO(209, 209, 209, 1),
                      ),
                    ),
                    cursorColor: UiColors.color3,
                    decoration: InputDecoration(
                        enabled: state.isEnabled[1],
                        border: InputBorder.none,
                        isCollapsed: true)),
              ),
              handlerButton: GestureDetector(
                onTap: () {
                  FormState formState =
                      SharedController.formKeys[1].currentState;
                  if (formState.validate()) {
                    formState.save();
                    if (!contact.isNull && contact != widget.model.contact) {
                      state
                          .updateSingleData(1, "contact", contact)
                          .then((value) {
                        if (value == true) {
                          Fluttertoast.showToast(msg: "Updated");
                          return;
                        }
                      });
                    } else {
                      state.setIsEnabled(1, !state.isEnabled[1]);
                    }
                  }
                },
                child: !state.isEnabled[1]
                    ? Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: UiColors.color3,
                      )
                    : !state.isLoading
                        ? Text(
                            "Save",
                            style: TextStyle(color: Colors.red),
                          )
                        : loading,
              ),
            ),
            onTap: () => state.setIsEnabled(1, true),
          );
        }),
        CustomDivider(),
        GetBuilder<SharedController>(builder: (state) {
          return GestureDetector(
            child: AccountData(
              label: 'Location',
              textFormField: Form(
                key: SharedController.formKeys[2],
                child: TextFormField(
                    onSaved: (newValue) => location = newValue,
                    validator: (location) =>
                        ValidationService.validateLocation(location),
                    initialValue: widget.model.location,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: state.isEnabled[2]
                            ? UiColors.color3
                            : Color.fromRGBO(209, 209, 209, 1),
                      ),
                    ),
                    cursorColor: UiColors.color3,
                    decoration: InputDecoration(
                        enabled: state.isEnabled[2],
                        border: InputBorder.none,
                        isCollapsed: true)),
              ),
              handlerButton: GestureDetector(
                onTap: () {
                  FormState formState =
                      SharedController.formKeys[2].currentState;
                  if (formState.validate()) {
                    formState.save();
                    if (!location.isNull && location != widget.model.location) {
                      state
                          .updateSingleData(2, "location", location)
                          .then((value) {
                        if (value == true) {
                          Fluttertoast.showToast(msg: "Updated");
                          return;
                        }
                      });
                    } else {
                      state.setIsEnabled(2, !state.isEnabled[2]);
                    }
                  }
                },
                child: !state.isEnabled[2]
                    ? Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: UiColors.color3,
                      )
                    : !state.isLoading
                        ? Text(
                            "Save",
                            style: TextStyle(color: Colors.red),
                          )
                        : loading,
              ),
            ),
            onTap: () => state.setIsEnabled(0, true),
          );
        }),
        CustomDivider(),
        GetBuilder<SharedController>(builder: (state) {
          return AccountData(
            label: 'Account Type',
            textFormField: Form(
              key: SharedController.formKeys[3],
              child: TextFormField(
                  initialValue: widget.model.accountType.inCaps,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: UiColors.color3,
                    ),
                  ),
                  decoration: InputDecoration(
                      enabled: false,
                      border: InputBorder.none,
                      isCollapsed: true)),
            ),
            handlerButton: Text(
              "Register business",
              style: TextStyle(color: Colors.red),
            ),
          );
        }),
      ],
    );
  }
}
