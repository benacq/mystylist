import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_stylist/controllers/stylist_controller.dart';
import 'package:my_stylist/controllers/validation_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/responsive.dart';
import '../../../reusablecomponents/button.dart';
import '../../../reusablecomponents/label.dart';
import '../../../reusablecomponents/label_seperator.dart';
import '../../../reusablecomponents/textbox_seperator.dart';
import '../../../reusablecomponents/txt_decoration.dart';

class AddServiceform extends StatelessWidget {
  final StylistController stylistController = Get.put(StylistController());
  final loader = SpinKitFadingFour(
    color: Colors.blueAccent,
    size: 35.0,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: StylistController.addServiceFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(
            labeltext: 'Service name',
          ),
          LabelSeperator(),
          TextFormField(
            onSaved: (service) => stylistController.setserviceName = service,
            validator: (servicename) =>
                ValidationService.validateserviceName(servicename),
            style: TextStyle(color: UiColors.color3),
            decoration: textInputDecoration(hint: 'Hair cut'),
          ),
          TextboxSeperator(),
          Label(
            labeltext: 'Price',
          ),
          LabelSeperator(),
          TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (price) => stylistController.setprice = price,
            validator: (price) => ValidationService.validateprice(price),
            style: TextStyle(color: UiColors.color3),
            decoration: textInputDecoration(hint: 'Ghc 10'),
          ),
          TextboxSeperator(),
          Label(
            labeltext: 'Estimated duratuin',
          ),
          LabelSeperator(),
          TextFormField(
            onSaved: (duration) => stylistController.setduration = duration,
            validator: (duration) =>
                ValidationService.validateduration(duration),
            style: TextStyle(color: UiColors.color3),
            decoration: textInputDecoration(hint: '30 minutes'),
          ),
          TextboxSeperator(),
          Label(
            labeltext: 'Number of booking expected per day',
          ),
          LabelSeperator(),
          TextFormField(
            onSaved: (expectedNumber) =>
                stylistController.setnumberofBookingsExpected = expectedNumber,
            validator: (expectedNumber) =>
                ValidationService.validateexpectedNumber(expectedNumber),
            keyboardType: TextInputType.number,
            style: TextStyle(color: UiColors.color3),
            decoration: textInputDecoration(hint: '20'),
          ),
          SizedBox(
            height: screenHeight(context, 0.07),
          ),
          GetBuilder<StylistController>(builder: (_) {
            return ReusableButton(
                label: _.isLoading ? loader : Text('Add Service',style: TextStyle(color: UiColors.color1),),
                onpress: () {
                  stylistController.addService();
                  print(_.isLoading);
                });
          }),
        ],
      ),
    );
  }
}
