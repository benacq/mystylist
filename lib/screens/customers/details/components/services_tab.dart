import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_stylist/controllers/stylist_controller.dart';
import 'package:my_stylist/models/service_model.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';
import '../../../../utils/message_consts.dart' as Constants;

class ServicesTab extends StatelessWidget {
  final DocumentReference tappedItemRef;
  ServicesTab({this.tappedItemRef});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<List<ServiceModel>>(
            stream: StylistController().getServices(tappedItemRef),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Constants.LOADER,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data.isEmpty) {
                return Center(
                  child: Text(
                    'Stylist has no Service',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: UiColors.color3,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }
              List<ServiceModel> serviceList = snapshot.data;
              return ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: serviceList.length,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: screenWidth(context, 0.5),
                                  child: Text(
                                    serviceList[index].serviceName,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: UiColors.color3),
                                    ),
                                  ),
                                ),
                                Text(
                                  serviceList[index].duration,
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
                                'Ghc ${serviceList[index].price}',
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
            }));
  }
}
