import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_stylist/controllers/onboarding_controller.dart';
import 'package:my_stylist/screens/onboarding/components/pages.dart';
import 'package:my_stylist/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/onboarding_progress_indicator.dart';
import '../../utils/message_consts.dart' as Constants;

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingController _onboardingController =
      Get.put(OnboardingController());

  final int _numPages = 3;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(GetBuilder<OnboardingController>(builder: (_) {
        return i == _.currentPage ? indicator(true) : indicator(false);
      }));
    }
    return list;
  }

  final _loader = SpinKitFadingCircle(
    color: Colors.blueAccent,
    size: 45.0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(builder: (pageTracker) {
      return ModalProgressHUD(
        inAsyncCall: _onboardingController.isLoading,
        opacity: 0.7,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder<SharedPreferences>(
                future: _onboardingController.initialPreference(),
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
                  }
                  SharedPreferences prefs = snapshot.data;
                  _onboardingController.setPreferenceValues();
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              height: screenHeight(context, 0.74),
                              child: OnboardingPageView(prefs: prefs)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildPageIndicator(),
                          ),
                          (pageTracker.currentPage == 0)
                              ? Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: FlatButton(
                                    onPressed: () => _onboardingController
                                        .validatePageViewFirstPage(),
                                    color: Color(0xffDEDEDE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 25,
                                      ),
                                      child: Text(
                                        'Next',
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16),
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
                                            OnboardingController.pageController
                                                .previousPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          borderSide: BorderSide(
                                              color: Color(0xFFADADAD),
                                              width: 1.4),
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
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth(context, 0.1),
                                      ),
                                      Expanded(
                                        child: FlatButton(
                                          onPressed: () {
                                            if (pageTracker.currentPage != 2) {
                                              OnboardingController
                                                  .pageController
                                                  .nextPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.ease,
                                              );
                                            } else {
                                              _onboardingController
                                                  .validatePageViewLastPage();
                                            }
                                          },
                                          color: Color(0xffDEDEDE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 15.0,
                                            ),
                                            child: Text(
                                              pageTracker.currentPage == 2
                                                  ? 'Go'
                                                  : 'Next',
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
                  );
                }),
          ),
        ),
      );
    });
  }
}
