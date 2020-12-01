import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/models/stylist_model.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/responsive.dart';

class FeaturedStylists extends StatelessWidget {
  final List<StylistModel> featuredStylists;
  FeaturedStylists({key, this.featuredStylists}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(featuredStylists.length);

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: screenHeight(context, 0.36),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
            width: screenWidth(
              context,
              0.02,
            ),
          ),
          itemCount: featuredStylists.length,
          itemBuilder: (context, index) {
            return Container(
              width: screenWidth(context, 0.60),
              decoration: BoxDecoration(
                color: UiColors.color1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight(context, 0.23),
                    width: screenWidth(context, 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      featuredStylists[index].businessName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: UiColors.color3,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      featuredStylists[index].contact,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: UiColors.color4,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      featuredStylists[index].location,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: UiColors.color4,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
