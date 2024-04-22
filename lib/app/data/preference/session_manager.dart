import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  static SharedPreferences get to => Get.find<SharedPreferences>();

  static const _boarding = "boarding";
  static const _accessToken = "access_token";

  //Boarding
  static Future<bool> setBoarding(bool value) {
    return to.setBool(_boarding, value);
  }

  static bool? getBoarding() {
    return to.getBool(_boarding);
  }

  //Access Token API
  static Future<bool> setAccessToken(String value) {
    return to.setString(_accessToken, value);
  }

  static String? getAccessToken() {
    return to.getString(_accessToken);
  }

  static Future<bool> removeAccessToken() {
    return to.remove(_accessToken);
  }
}