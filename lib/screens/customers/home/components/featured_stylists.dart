import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/responsive.dart';

class FeaturedStylists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: screenHeight(context, 0.35),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
            width: screenWidth(
              context,
              0.02,
            ),
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: screenHeight(context, 0.35),
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
                      color: Colors.red,
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
                      'Mike Barbering Salon',
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
                      'Kumasi',
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
                      '+233207834674',
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
