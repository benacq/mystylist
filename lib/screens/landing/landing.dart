import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/screens/customers/customer_navigation.dart';
import 'package:my_stylist/screens/landing/components/l_body.dart';
import 'package:my_stylist/screens/onboarding/onboarding.dart';
import 'package:my_stylist/screens/stylist/stylist_navigation.dart';
import '../../utils/message_consts.dart' as Constants;

class Landing extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<AuthController>().user == null
          ? Scaffold(
              backgroundColor: Colors.black87,
              body: Container(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.8), BlendMode.darken),
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/bg.jpg'),
                    ),
                  ),
                  child: LBody()))
          : SafeArea(
              child: FutureBuilder<dynamic>(
                  //Check if user is stylist, customer or yet to fill onboarding and redirect accordingly
                  future: controller.isOnboardingComplete(
                      Get.find<AuthController>().user.uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Scaffold(
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Constants.LOADER,
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Please wait...")
                          ],
                        ),
                      );
                    } else {
                      return checkAccountType(snapshot.data);
                    }
                  }),
            );
    });
  }

  Widget checkAccountType(dynamic status) {
    if (status == Constants.USER_ACCOUNT_BUSINESS) {
      return StylistNavigation();
    } else if (status == Constants.USER_ACCOUNT_CUSTOMER) {
      return CustomerNavigation();
    } else {
      return OnboardingScreen();
    }
  }
}
