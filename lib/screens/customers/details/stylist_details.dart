import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/models/stylist_model.dart';
import 'package:my_stylist/screens/customers/details/components/gallery_tab.dart';
import 'package:my_stylist/screens/customers/details/components/services_tab.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';

enum CustomTab { services, gallery }

class StylistDetails extends StatefulWidget {
  final StylistModel featuredStylists;
  StylistDetails({this.featuredStylists});

  @override
  _StylistDetailsState createState() => _StylistDetailsState();
}

class _StylistDetailsState extends State<StylistDetails> {
  CustomTab customTab = CustomTab.services;

  @override
  Widget build(BuildContext context) {
    // updateUI();

    return Scaffold(
      backgroundColor: UiColors.color2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight(context, 0.25),
                width: screenWidth(context, 1),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    colorFilter:
                        ColorFilter.mode(Colors.black38, BlendMode.overlay),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: UiColors.color3,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: UiColors.color3,
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Color(0xff000000),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.featuredStylists.businessName,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: UiColors.color3,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.002),
                    ),
                    Text(
                      widget.featuredStylists.contact,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: UiColors.color4,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.002),
                    ),
                    Text(
                      widget.featuredStylists.location,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: UiColors.color4,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.03),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              customTab = CustomTab.services;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Services',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: customTab == CustomTab.services
                                          ? UiColors.color3
                                          : UiColors.color4,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              customTab == CustomTab.services
                                  ? Container(
                                      height: screenHeight(context, 0.003),
                                      width: screenWidth(context, 0.13),
                                      color: UiColors.color3,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, 0.06),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              customTab = CustomTab.gallery;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Gallery',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: customTab == CustomTab.gallery
                                          ? UiColors.color3
                                          : UiColors.color4,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              customTab == CustomTab.gallery
                                  ? Container(
                                      height: screenHeight(context, 0.003),
                                      width: screenWidth(context, 0.13),
                                      color: UiColors.color3,
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.03),
                    ),
                    customTab == CustomTab.services
                        ? ServicesTab(
                            tappedItemRef: widget.featuredStylists.stylistRef)
                        : GalleryTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
