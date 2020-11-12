import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sight {
  final String name;
  final String image;
  final LatLng location;
  final String bodyText;
  final double rating;
  final IconData icon;
  //final Url url;
  final String url;
  bool dontAlertMe;
  bool startSetting;
  // double distance;

  Rx<double> distance = Rx<double>();

  Sight({
    this.name,
    this.image,
    this.location,
    this.bodyText,
    this.url,
    this.rating,
    this.icon,
    this.dontAlertMe,
  });

  Future get avstand async {
    try {
      //pass
      Position position = await GeolocatorPlatform.instance.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      var value = await Geolocator.distanceBetween(location.latitude,
          location.longitude, position.latitude, position.longitude);
      this.distance.value = value;
      // print('her kommer avstanden fra avstand');
      // print(value);
      return value.round();
    } catch (e) {
      print(e);
    }
  }

  alertOff() {
    this.dontAlertMe = true;
  }

  alertOn() {
    this.dontAlertMe = false;
  }

  // Future calculateDistance(latitude, longitude) async {
  //   return await Geolocator.distanceBetween(
  //       location.latitude, location.longitude, latitude, longitude);
  // }
}

List<Sight> sightList = [
  Sight(
    name: 'The Fish Market',
    image: 'torget.jpg',
    rating: 4,
    location: LatLng(60.394512, 5.324772),
    bodyText:
        "Bergen’s fish market is one of the town's most famous spot. Here you can take a walk along the bustling market and check out the fresh culinary treasures from the sea. The Bergen fish market is a picturesque and lively spot in the heart of Bergen. As the name would suggest the stalls in the market mainly sells fish, but you can also buy fruit, vegetables, handcrafted objects and souvenirs. A lot of people enjoy buying fresh shrimp and eat them by the market stalls or at Bryggen next to the fish market. The Bergen fish market is most active during the summer, during the winter season and colder periods a lot of trade has moved indoor to the Mathallen.",
    url:
        'https://en.visitbergen.com/things-to-do/fish-market-in-bergen-p822253',
    icon: MaterialIcons.camera_alt,
    dontAlertMe: true,
  ),
  Sight(
    name: 'Bryggen',
    image: 'bryggen2.jpg',
    location: LatLng(60.397120, 5.322959),
    rating: 5,
    bodyText:
        'Bryggen is one of Bergen\'s and Norway\'s main attractions. Bryggen was built after the great fire in 1702 and is included on UNESCO\'s World Heritage List. The very first buildings in Bergen were situated at Bryggen, which has been a vibrant and important area of the city for many centuries.',
    url: 'https://www.visitbergen.com/ting-a-gjore/bryggen-i-bergen-p878553',
    icon: MaterialIcons.camera_alt,
    dontAlertMe: true,
  ),
  Sight(
    name: 'Grieg Medialog AS',
    image: 'medialog.jpg',
    location: LatLng(60.392090, 5.321320),
    rating: 6,
    bodyText:
        'TRYKKSAKER: Totalleverandør av grafiske tjenester, trykksaker og profilerings­artikler\nNETTSIDER: Skreddersydde, profesjonelle nettsider / hjemmesider, design og webløsninger,.\n\bDESIGN\b: Alt fra logodesign, annonser, displaymateriell til reklametrykksaker',
    url: 'http://medialog.no',
    icon: MaterialIcons.touch_app,
    dontAlertMe: true,
  ),
  Sight(
    name: 'Coopbutikk',
    image: 'coop.jpg',
    rating: 2,
    location: LatLng(60.393523, 5.327724),
    bodyText:
        'lets add some text here and maybe a reference to somwehere (URI link, mabe)',
    url: 'http://medialog.no',
    icon: MaterialIcons.local_grocery_store,
    dontAlertMe: false,
  ),
  Sight(
    name: 'Fløibanen',
    image: 'floybanen.jpg',
    rating: 4,
    location: LatLng(60.396412, 5.328563),
    bodyText:
        'The Fløibanen funicular in Bergen is one of Norway’s best-known attractions. '
        'Fløibanen can be found in the heart of Bergen, 150 m from Fisketorget – '
        'the fish market – and Bryggen wharf. It’s only a 10-minute walk to the lower '
        'station from where the cruise ships dock. The journey up to Fløyen (320 m above'
        ' sea level) takes about 5–8 minutes.',
    url: 'https://www.floyen.no/en/floibanen/',
    icon: MaterialIcons.tram,
    dontAlertMe: false,
  ),
  Sight(
    name: 'Aquarium',
    image: 'aquarium.jpg',
    rating: 3.5,
    location: LatLng(60.399738, 5.304649),
    bodyText:
        'Meet the sea lions, the creepy - but great crocodiles, fish and the fascinating snakes at '
        'Bergen Aquarium. Film screening and feeding daily. Book online.'
        'At the Bergen Aquarium you will meet famous local personalities like Pingrid Alexandra, Vitus and Zelters.'
        ' You can also experience the great atmosphere created by the young and old citizens of Bergen '
        'who keep coming back to say hello to the animals - and to meet each other. '
        'In more than 50 large and small aquariums you can watch in fascination all the weird and '
        'wonderful things that go on beneath the surface at close quarters. '
        'In addition to getting to know the cod, and all the other creatures that live along '
        'the Norwegian coast, you can meet animals like crocodiles, snakes, lizards and common '
        'marmosets in the tropical section',
    url: 'https://en.visitbergen.com/things-to-do/bergen-aquarium-p822383',
    icon: MaterialIcons.photo,
    dontAlertMe: false,
  ),
  Sight(
    name: 'Brann Stadium',
    image: 'brannstadium.jpg',
    rating: 3.5,
    location: LatLng(60.366928, 5.357433),
    bodyText:
        'Brann Stadion is owned by the club. It was built in 1919, but has since been modernized several times. '
        'A new stand was erected in 2006 and opened in May 2007. The new main stand was finished only days '
        'before the opening of the 2007 season.'
        'Brann Stadion has hosted 17 Norwegian international fixtures since 1933, '
        'the first against Wales in a 1-2 defeat. Since then Norway has not lost in '
        'Bergen, and has won twelve of the seventeen international fixtures at Brann Stadion.'
        'The current capacity is 16.750.',
    url: 'https://www.brann.no/english/the-stadium',
    icon: MaterialIcons.photo,
    dontAlertMe: false,
  ),
];
