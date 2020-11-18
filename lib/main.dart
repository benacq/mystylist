import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_stylist/controllers/auth_controller.dart';
import 'package:my_stylist/controllers/bindings/auth_binding.dart';
import 'package:my_stylist/screens/landing/landing.dart';
import 'package:my_stylist/screens/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await AuthController().isOnboardingComplete("opWBrrQ49Cgy0EtrTAlCy77BcX72");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Mystylist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Landing(),
      // home: OnboardingScreen(),
    );
  }
}
