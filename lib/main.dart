import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/main_page.dart';
import 'views/sights_page.dart';

void main() {
  runApp(GetMaterialApp(
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: '/home',
    defaultTransition: Transition.native,
    // translations: MyTranslations(),
    //locale: Locale('no'),
    getPages: [
      //Simple GetPage
      GetPage(name: '/home', page: () => MainPage()),
      // GetPage with custom transitions and bindings
      GetPage(
        name: '/sight',
        page: () => SightPage(),
        // customTransition: SizeTransitions(),
        // binding: SampleBind(),
      ),
      // GetPage with default transitions
    ],
  ));
}
