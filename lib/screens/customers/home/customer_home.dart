import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/screens/customers/home/components/discover_stylists.dart';
import 'package:my_stylist/screens/customers/home/components/featured_stylists.dart';
import '../../../utils/colors.dart';
import '../../../utils/responsive.dart';
import '../../reusablecomponents/txt_decoration.dart';

class CustomerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.color2,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                style: TextStyle(
                  color: UiColors.color3,
                ),
                decoration: textInputDecoration(
                  hint: 'Search',
                  sicon: IconButton(
                    icon: Icon(Icons.search),
                    color: UiColors.color3,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Featured Stylists',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: UiColors.color3,
                    fontWeight: FontWeight.w500,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            FeaturedStylists(),

            //Others
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Discover',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: UiColors.color3,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            DiscoverStylists(),
          ],
        )),
      ),
    );
  }
}

