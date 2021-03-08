import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:get/get.dart';

import '../classes.dart';
import '../pages/sight_page.dart';

class SightGoogleMap extends StatefulWidget {
  SightGoogleMap(
      {Key key, this.latitude, this.longitude, this.name, this.sightList})
      : super(key: key);

  @required
  final latitude;

  @required
  final longitude;

  @required
  final name;

  @required
  List<Sight> sightList;

  @override
  _SightGoogleMapState createState() => _SightGoogleMapState();
}

class _SightGoogleMapState extends State<SightGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      //onTap: null,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapToolbarEnabled: true,
      compassEnabled: true,
      buildingsEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        //TODO: Something is wrong with googlemap ?? seems to crash ios
        _controller.complete(controller);
      },
      markers: {
        for (var locationPlace in widget.sightList)
          Marker(
            markerId: MarkerId(locationPlace.name),
            position: LatLng(locationPlace.location.latitude,
                locationPlace.location.longitude),
            infoWindow: InfoWindow(
              title: locationPlace.name,
              onTap: () {
                Get.off(ShowSight(sight: locationPlace, sightList: sightList));
              },
              snippet: 'Rating: ${locationPlace.rating}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta),
          ),
        Marker(
          markerId: MarkerId(widget.name),
          position: LatLng(widget.latitude, widget.longitude),
          infoWindow: InfoWindow(
            title: widget.name,
            onTap: () {
              Get.back();
            },
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        )
      },
    );
  }
}
