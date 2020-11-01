import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/screens/customers/home/customer_home.dart';
import 'package:my_stylist/screens/landing/components/l_body.dart';

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
          : CustomerHome();
    });
  }
}
