import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragments_of_flutter/models/places.dart';
import 'package:get/get.dart';
import 'package:fragments_of_flutter/controllers/sights_controller.dart';
import 'package:fragments_of_flutter/controllers/location_controller.dart';
import 'package:fragments_of_flutter/controllers/prefs_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'sights_page.dart';

class MainPage extends StatelessWidget {
  final placesController = Get.put(SightsController());
  final locationController = Get.put(LocationController());
  final prefsController = Get.put(PrefsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('My App'),
      ),
      body: Container(
        // color: Colors.amber,
        child: Column(
          children: [
            // GetX<LocationController>(builder: (controller) {
            //   return FutureBuilder(
            //     future: controller.getLocation(),
            //     builder: (ctx, snapshot) {
            //       if (snapshot.hasData) {
            //         return Text(
            //           '${snapshot.data.toString()}  m',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.w200,
            //           ),
            //         );
            //       } else {
            //         return SpinKitCircle(
            //           color: Colors.black26,
            //           size: 15.0,
            //         );
            //       }
            //     },
            //   );
            // }),
            GetX<SightsController>(builder: (controller) {
              return Column(
                children: [
                  for (var sight in controller.placesList)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 4),
                      child: Card(
                        child: Tooltip(
                          message: 'Hold down to toggle alerts',
                          child: ListTile(
                            onLongPress: () {
                              sight.alertOff();
                            },
                            onTap: () {
                              Get.to(SightPage(sight: sight));
                            },
                            leading: Image(
                              image: AssetImage(
                                'assets/${sight.image}',
                              ),
                            ),
                            title: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(sight.name),
                                ),
                                Visibility(
                                  visible: (!sight.dontAlertMe),
                                  //TODO: fix visibility
                                  // visible: (!sight.dontAlertMe &&
                                  //     (alertSetting != '')),
                                  child: Icon(
                                    MaterialIcons.alarm_on,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                ),

                                SizedBox(width: 4),
                                // GetX<PrefsController>(builder: (controller) {
                                //   return FutureBuilder(
                                //     future: controller.meters.value,
                                //     builder: (ctx, snapshot) {
                                //       if (snapshot.hasData) {
                                //         return Icon(
                                //           sight.icon,
                                //           size: 16,
                                //           color:
                                //               // sight.distance < double.parse(PrefsController meters[0])
                                //               // TODO: FIx meters
                                //               sight.distance < double.parse(100)
                                //                   ? Colors.green
                                //                   : Colors.blue[600],
                                //         );
                                //       } else {
                                //         return SpinKitCircle(
                                //           color: Colors.black26,
                                //           size: 15.0,
                                //         );
                                //       }
                                //     },
                                //   );
                                // }),
                                // ObxWidget() => Icon(
                                //     sight.icon,
                                //     size: 16,
                                //     color:
                                //         // sight.distance < double.parse(PrefsController meters[0])
                                //         // TODO: FIx meters
                                //         sight.distance < double.parse(meters)
                                //             ? Colors.green
                                //             : Colors.blue[600],
                                //   ),
                                // ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    StarRating(
                                      size: 13,
                                      rating: sight.rating.toDouble(),
                                      color: Colors.amber[400],
                                      starCount: sight.rating.round(),
                                    ),
                                    Text(
                                      ' (${sight.rating.toString()})',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),

                                FutureBuilder(
                                  future: sight.avstand,
                                  builder: (ctx, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        '${snapshot.data.toString()} m',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      );
                                    } else {
                                      return SpinKitCircle(
                                        color: Colors.black26,
                                        size: 15.0,
                                      );
                                    }
                                  },
                                ),

                                // (sight.distance != 0)
                                //     ? Text(
                                //         '${sight.distance.round().toString()} m',
                                //         style: TextStyle(
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.w200,
                                //         ),
                                //       )
                                //     : SpinKitCircle(
                                //         color: Colors.black26,
                                //         size: 15.0,
                                //       ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
            // GetX<LocationController>(builder: (controller) {
            //   return FutureBuilder(
            //     future: controller.getUserLocation(),
            //     builder: (ctx, snapshot) {
            //       if (snapshot.hasData) {
            //         return Text(
            //           '${snapshot.data.toString()}  m',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.w200,
            //           ),
            //         );
            //       } else {
            //         return SpinKitCircle(
            //           color: Colors.black26,
            //           size: 15.0,
            //         );
            //       }
            //     },
            //   );
            // }),
          ],
        ),
        // child: GetX<SightsController>(builder: (controller) {
        //   return ListView.builder(
        //     itemCount: controller.placesList.length,
        //     itemBuilder: (context, index) {
        //       var site = controller.placesList[index];
        //       return Card(
        //         child: Row(
        //           children: [
        //             Text(controller.placesList[index].name),
        //             Text(' or : ${site.name}'),
        //             // FlatButton(
        //             //     child: Text('Press me'),
        //             //     onPressed: () {
        //             //       controller.sortItems();
        //             //     }),
        //           ],
        //         ),
        //       );
        //     },
        //   );
        // }),
      ),
      floatingActionButton: GetX<SightsController>(builder: (controller) {
        return FloatingActionButton.extended(
          splashColor: Colors.white24,
          onPressed: () {
            controller.sortItems();
          },
          label: Text(
            controller.sortLabel.value,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
          ),
          backgroundColor: controller.colorVariable.value,
          icon: controller.sortIcon.value,
        );
      }),
    );
  }
}
