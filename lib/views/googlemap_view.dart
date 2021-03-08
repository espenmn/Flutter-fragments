import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fragments_of_flutter/widgets/googlemap_widget.dart';
import 'package:get/get.dart';

class SightMapView extends StatelessWidget {
  final LocationController placesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Bergen Map'),
        centerTitle: true,
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(MaterialCommunityIcons.home),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: (1 == 1)
          // (position != null)
          ? SizedBox(
              width: double.infinity,
              //height: 450,
              child: SightGoogleMap(
                latitude: latitude,
                longitude: longitude,
                name: name,
                sightList: _sightList,
              ),
            )
          : SpinKitChasingDots(color: Colors.amber),
    );
  }
}
