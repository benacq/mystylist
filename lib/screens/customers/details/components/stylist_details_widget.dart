import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/models/service_model.dart';
import 'package:my_stylist/screens/customers/details/stylist_details.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';

class DynamicInfo {

  Widget display(customTab, context) {
    // selected tab is services
    if (customTab == CustomTab.services) {
      return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: screenWidth(context, 1),
              height: screenHeight(context, 0.1),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: UiColors.color4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth(context, 0.5),
                          child: Text(
                            'service name',
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15, color: UiColors.color3),
                            ),
                          ),
                        ),
                        Text(
                          '30 m',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: UiColors.color4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Center(
                      child: Text(
                        'Ghc 89',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: UiColors.color4),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth(context, 0.05),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: UiColors.color3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'BOOK',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: UiColors.color2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Center(
          child: Container(
        child: Text('Gallery images will go here'),
      ));
    }
  }
}
