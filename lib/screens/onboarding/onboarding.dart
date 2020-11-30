import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/controllers/onboarding_controller.dart';
import 'package:my_stylist/screens/onboarding/components/pages.dart';
import 'package:my_stylist/utils/responsive.dart';
import 'components/onboarding_progress_indicator.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: screenHeight(context, 0.74),
                    child: OnboardingPageView()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                GetBuilder<OnboardingController>(builder: (pageTracker) {
                  return pageTracker.currentPage == 0
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
                                    // pageTracker.initialStatePreference();
                                    OnboardingController.pageController
                                        .previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  borderSide: BorderSide(
                                      color: Color(0xFFADADAD), width: 1.4),
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
                                    borderRadius: BorderRadius.circular(6),
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
                                      OnboardingController.pageController
                                          .nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    } else {
                                      _onboardingController
                                          .validatePageViewLastPage();
                                    }
                                  },
                                  color: Color(0xffDEDEDE),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
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
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
