import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class PrefsController extends GetxController {
  RxBool hasVibration = false.obs;
  RxBool startSetting = false.obs;

  RxString alertSetting = ''.obs, // dont buzz at start
      _yourAdr,
      meters = '5'.obs,
      snooze = '2'.obs;

  Future<void> readPrefs() async {
    //Read setting (from control panel)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 5));
    //alertSetting == '';

    if (prefs.containsKey('popupSetting') && prefs.getBool('popupSetting')) {
      alertSetting.value = 'dialog';
    }

    if (prefs.containsKey('vibrationSetting') &&
        prefs.getBool('vibrationSetting')) {
      alertSetting.value = alertSetting + 'vibration';
    }

    if (prefs.containsKey('meters')) {
      meters.value = prefs.getString('meters');
    }
    if (prefs.containsKey('snooze')) {
      snooze.value = prefs.getString('snooze');
    }
    if (prefs.containsKey('startSetting') && prefs.getBool('startSetting')) {
      startSetting.value = true;
    }
  }

  Future<void> _checkVibration() async {
    if (await Vibration.hasVibrator()) {
      hasVibration.value = true;
    }
  }

  // _unikIcons = _uniqueIcons();
  // _iconLenght = _unikIcons.length;

}
