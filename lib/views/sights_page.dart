import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

//import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/places.dart';
// import '../pages/googlemap_view.dart';

class SightPage extends StatefulWidget {
  SightPage({Key key, this.sight, this.sightList}) : super(key: key);
  Sight sight;
  List<Sight> sightList;

  @override
  _SightPageState createState() => _SightPageState();
}

class _SightPageState extends State<SightPage> {
  Position position;
  int dragBy;
  int pageIndex;
  int indexPlace;
  bool leftDrag;
  //var sightCount = sightList.length - 1;
  double _fontSize = 15.5;

  var geolocator = Geolocator();

  @override
  void initState() {
    readFontSize();

    // _updateDistances();
    // geolocator
    //     .getPositionStream(LocationOptions(
    //         accuracy: LocationAccuracy.best,
    //         distanceFilter: 2,
    //         timeInterval: 10000))
    //     .listen((position) {
    //   _getPosition();
    // });
    super.initState();
  }

  Future<void> readFontSize() async {
    //used saved settings for fontsize
    _fontSize = 15.5;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('fontSize')) {
      setState(() {
        _fontSize = prefs.getDouble('fontSize');
      });
    }
  }

  // Future<void> _getPosition() async {
  //   Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then(
  //         (val) => setState(
  //           () {
  //             position = val;
  //           },
  //         ),
  //       );
  // }

  _changeRight() {
    // TODO: Find out why SightLenght does not work
    indexPlace = (widget.sightList.indexOf(widget.sight));
    if (indexPlace < widget.sightList.length - 1) {
      pageIndex = indexPlace + 1;
    } else {
      pageIndex = 0;
    }
    setState(() {
      widget.sight = widget.sightList[pageIndex];
    });
  }

  _changeLeft() {
    indexPlace = (widget.sightList.indexOf(widget.sight));
    if (indexPlace > 0) {
      pageIndex = indexPlace - 1;
    } else {
      pageIndex = widget.sightList.length - 1;
    }
    setState(() {
      widget.sight = widget.sightList[pageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(widget.sight.name),
        centerTitle: true,
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(MaterialCommunityIcons.home),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onLongPress: () {
          setState(() {
            widget.sight.dontAlertMe = false;
          });
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx.abs() > 3) {
            setState(() {
              Navigator.of(context).pop();
            });
          }
        },
        child: ListView(children: <Widget>[
          Image(
            height: MediaQuery.of(context).size.width * 0.67,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            image: AssetImage('assets/${widget.sight.image}'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
            child: Center(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_left,
                      size: 36,
                      color: Colors.grey[500],
                    ),
                    onPressed: _changeLeft,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          widget.sight.icon,
                          size: 18,
                          color: Colors.blue[500],
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        (widget.sight.distance != 0)
                            ? Obx(
                                child: Text(
                                  // 'Distance: ${widget.sight.distance.round()} m',
                                  'Distance: ${widget.sight.calculateDistance()} m',

                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 13),
                                ),
                              )
                            : Text(
                                'Location disabled',
                                style: TextStyle(
                                    color: Colors.grey[300], fontSize: 12),
                              ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_right,
                      size: 36,
                      //this is not gray. use 400 or drop in, probably
                      color: Colors.grey[500],
                    ),
                    onPressed: _changeRight,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
            child: Center(
              child: Text(
                widget.sight.name,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Center(
            child: Tooltip(
              message: 'Click for Weather',
              child: FlatButton(
                //splashColor: Colors.amber,
                onPressed: () {
                  _launchURL(
                      'https://www.storm.no/stedssok/?lng=${widget.sight.location.longitude}&lat=${widget.sight.location.latitude}&zoom=0');
                },
                child: Text(
                  'Lat ${widget.sight.location.latitude} '
                  ' Long ${widget.sight.location.longitude}',
                  style: TextStyle(
                      color: Colors.grey[400], height: 0, fontSize: 11),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    var sightUrl = widget.sight.url;
                    _launchURL(sightUrl);
                  },
                  color: Colors.amber[300],
                  icon: Icon(Icons.open_in_browser),
                  label: Text(
                    'Web',
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {
                    // Get.to(
                    //   SightMap(
                    //     sight: widget.sight,
                    //     sightList: widget.sightList,
                    //   ),
                    // );
                  },
                  color: Colors.amber[300],
                  icon: Icon(Icons.map),
                  label: Text(
                    'Map',
                  ),
                ),
                (position != null)
                    ? FlatButton.icon(
                        onPressed: () {
                          _launchURL(
                              "https://www.google.es/maps/dir/'${widget.sight.location.latitude},${widget.sight.location.longitude}'/'${position.latitude},${position.longitude}'");
                        },
                        color: Colors.amber[300],
                        icon: Icon(Icons.directions),
                        label: Text('Directions'),
                      )
                    : FlatButton.icon(
                        onPressed: () {
                          _launchURL(
                              "http://maps.google.com/?q=${widget.sight.location.latitude},${widget.sight.location.longitude}&z=17z");
                        },
                        color: Colors.amber[300],
                        icon: Icon(Icons.map),
                        label: Text('GMap'),
                      )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: GestureDetector(
              onDoubleTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                setState(() {
                  _fontSize = _fontSize + 2.5;
                  if (_fontSize > 22) {
                    _fontSize = 15.5;
                  }
                  //TODO: Feels wrong to set fontsize here
                  prefs.setDouble('fontSize', _fontSize);
                });
              },
              child: Text(
                '${widget.sight.bodyText}',
                style: TextStyle(
                  fontSize: _fontSize,
                  height: 1.33,
                ),
              ),
            ),
          ),
//          Markdown(
//            data: widget.sight.bodyText,
//          ),
        ]),
      ),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
