import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/controllers/onboarding_controller.dart';
import 'package:my_stylist/screens/customers/home/customer_home.dart';
import 'package:my_stylist/screens/landing/components/l_body.dart';
import 'package:my_stylist/screens/onboarding/onboarding.dart';
import '../../utils/message_consts.dart' as Constants;
import 'package:my_stylist/screens/stylist/home/stylist_home.dart';

class Landing extends GetWidget<AuthController> {
  final _loader = SpinKitFadingCircle(
    color: Colors.blueAccent,
    size: 45.0,
  );

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
                            _loader,
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
      return StylistHome();
    } else if (status == Constants.USER_ACCOUNT_CUSTOMER) {
      return CustomerHome();
    } else {
      return OnboardingScreen();
    }
  }
}
