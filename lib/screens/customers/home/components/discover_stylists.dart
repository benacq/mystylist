import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/models/stylist_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/responsive.dart';

class DiscoverStylists extends StatelessWidget {
  final List<StylistModel> nonFeaturedStylist;
  DiscoverStylists({Key key, this.nonFeaturedStylist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ListView.separated(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
          height: screenHeight(context, 0.01),
        ),
        itemBuilder: (context, index) {
          return Container(
            height: screenHeight(context, 0.1),
            width: screenWidth(context, 1),
            decoration: BoxDecoration(
                color: UiColors.color1,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nonFeaturedStylist[index].businessName,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: UiColors.color3,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        nonFeaturedStylist[index].location,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: UiColors.color4,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: nonFeaturedStylist.length,
      ),
    );
  }
}
