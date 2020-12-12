import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_stylist/utils/colors.dart';
import 'package:my_stylist/utils/responsive.dart';

buildShowModalBottomSheet(context, featuredStylists) {
  // get location longitude and latitude
  var lat = featuredStylists.latitude;
  var long = featuredStylists.longitude;
  print(lat);
  print(long);

  //initialize googl map ccontroller
  GoogleMapController mapController;

  //place marker on the map
  final Map<String, Marker> _markers = {};
  final marker = Marker(
    markerId: MarkerId("curr_loc"),
    position: LatLng(lat, long),
    infoWindow: InfoWindow(title: 'Stylists\'s location'),
  );
  _markers["Current Location"] = marker;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => Container(
      child: Container(
        // color: Color(0xff757575),
        child: Container(
          height: screenHeight(context, 0.97),
          color: UiColors.color2,
          child: Container(
            height: screenHeight(context, 0.97),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat ?? "", long ?? ""),
                zoom: 15.0,
              ),
              markers: _markers.values.toSet(),
            ),
          ),
        ),
      ),
    ),
  );
}
