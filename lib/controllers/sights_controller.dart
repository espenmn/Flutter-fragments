import 'package:fragments_of_flutter/models/places.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SightsController extends GetxController {
  var placesList = List<Sight>().obs;
  var sortIndex = 0.obs;
  var colorVariable = Colors.amber[600].obs;
  var sortIcon = Icon(Icons.star_border).obs;
  RxString sortLabel = 'Sort'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSights();
  }

  void fetchSights() async {
    // TODO: Load this from server
    await Future.delayed(
      Duration(milliseconds: 1),
    );
    // var serverResponse = [];
    var placesResult = sightList;
    placesList.assignAll(placesResult);
  }

  void sortItems() {
    if (sortIndex.value == 0) {
      placesList.sort((a, b) => b.rating.compareTo(a.rating));
      colorVariable.value = Colors.amber[600];
      sortIcon.value = Icon(Icons.star_border);
      sortLabel.value = 'Rating';
    } else if (sortIndex.value == 1) {
      placesList.sort((a, b) => a.name.compareTo(b.name));
      colorVariable.value = Colors.grey[800];
      sortIcon.value = Icon(Icons.sort_by_alpha);
      sortLabel.value = 'Name';
    } else if (sortIndex.value == 2) {
      sightList.sort((b, a) => b.distance.compareTo(a.distance));
      colorVariable.value = Colors.red[900];
      sortIcon.value = Icon(Icons.directions_walk);
      sortLabel.value = 'Distance';
    } else {
      placesList.sort((b, a) => b.icon.toString().compareTo(a.icon.toString()));
      colorVariable.value = Colors.blue[500];
      sortIcon.value = Icon(Icons.category);
      sortLabel.value = 'Category';
      sortIndex.value = -1;
    }

    sortIndex.value++;
  }
}
