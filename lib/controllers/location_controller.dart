import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class LocationController extends GetxController {
  double latitude;
  double longitude;
  String locationAddress = 'Unknown address';

  Future<void> getLocation() async {
    try {
      Position position = await GeolocatorPlatform.instance.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      latitude = position.latitude;
      longitude = position.longitude;

      // Coordinates coordinates = Coordinates(latitude, longitude);
      // var addresses =
      //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // var first = addresses.first;
      // locationAddress = first.locality;
      // return locationAddress;

      return position;
    } catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        print('denied');
      }
    }
  }

  Future<void> getUserLocation() async {
    //call this async method from whereever you need
    try {
      final coordinates = new Coordinates(latitude, longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      // locationAddress = first.subLocality + ', ' + first.subAdminArea;
      locationAddress = first.locality;
      return locationAddress;
    } catch (e) {
      print(e);
    }
  }
}
