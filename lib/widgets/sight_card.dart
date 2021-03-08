import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:async/async.dart';

class SightCard extends StatefulWidget {
  final String name;
  final String image;
  final LatLng location;
  final String bodyText;
  final int rating;
  final String url;

  SightCard({
    @required this.name,
    @required this.image,
    @required this.location,
    @required this.bodyText,
    @required this.rating,
    @required this.url,
  });

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  double _distance;

  @override
  void initState() {
    _doCalc();
    super.initState();
  }

  _doCalc() {
    Geolocator()
        .distanceBetween(
            widget.location.latitude, widget.location.longitude, 34.3, 12.5)
        .then(
          (val) => setState(
            () {
              _distance = val;
            },
          ),
        );
  }

  _openWeb() {
    print('you tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Card(
        child: ListTile(
          onTap: _openWeb,
          leading: Image(
            image: AssetImage(
              'assets/${widget.image}',
            ),
          ),
          title: Text(widget.name),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StarRating(
                size: 14.5,
                rating: widget.rating.toDouble(),
                color: Colors.blue[300],
                starCount: widget.rating,
              ),
              Text(
                '${_distance.round().toString()} m.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
